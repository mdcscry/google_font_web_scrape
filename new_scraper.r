library(readr)
library(dplyr)

# Unicode version - CHANGE THIS TO UPDATE
unicode_version <- "17.0.0"

# Base URL
base_url <- paste0("https://www.unicode.org/Public/", unicode_version, "/ucd/")

# Files to download
files <- c(
  "UnicodeData.txt",
  "Blocks.txt",
  "DerivedCoreProperties.txt",
  "PropList.txt",
  "Scripts.txt",
  "ScriptExtensions.txt"
)

# Download each file
#cat("Downloading Unicode", unicode_version, "files...\n")
# for (file in files) {
#   url <- paste0(base_url, file)
#   destfile <- file
#   download.file(url, destfile, mode = "wb")
#   cat("Downloaded:", file, "\n")
# }

# Emoji data is in a different subdirectory
#emoji_url <- paste0("https://www.unicode.org/Public/", unicode_version, "/ucd/emoji/emoji-data.txt")
#download.file(emoji_url, "emoji-data.txt", mode = "wb")
#cat("Downloaded: emoji-data.txt\n\n")

# Read UnicodeData.txt with headers
cat("Building master database...\n")
col_names <- c("code_point", "name", "category", "combining_class", 
               "bidi_class", "decomposition", "decimal", "digit", 
               "numeric", "mirrored", "unicode_1_name", "iso_comment",
               "uppercase", "lowercase", "titlecase")

unicode_data <- read_delim("UnicodeData.txt", 
                           delim = ";", 
                           col_names = col_names,
                           col_types = cols(.default = "c"))

# Read Blocks.txt (skip comments)
blocks <- read_delim("Blocks.txt", 
                     delim = "; ",
                     col_names = c("range", "block_name"),
                     comment = "#",
                     col_types = cols(.default = "c"))

#################

# Parse block ranges and create lookup
blocks <- blocks %>%
  mutate(
    start = sub("\\.\\..*", "", range),
    end = sub(".*\\.\\.", "", range)
  ) %>%
  select(block_name, start, end)

# Read Scripts.txt (skip comments)
scripts <- read_delim("Scripts.txt",
                      delim = "; ",
                      col_names = c("code_point_range", "script"),
                      comment = "#",
                      col_types = cols(.default = "c")) %>%
  filter(!is.na(script))

# For single code points in scripts, duplicate as range
scripts <- scripts %>%
  mutate(
    start = ifelse(grepl("\\.\\.", code_point_range),
                   sub("\\.\\..*", "", code_point_range),
                   code_point_range),
    end = ifelse(grepl("\\.\\.", code_point_range),
                 sub(".*\\.\\.", "", code_point_range),
                 code_point_range)
  )

# Function to find which block/script a code point belongs to
assign_block <- function(cp, blocks_df) {
  cp_int <- strtoi(cp, 16L)
  if (is.na(cp_int)) return(NA_character_)
  for (i in 1:nrow(blocks_df)) {
    start_int <- strtoi(blocks_df$start[i], 16L)
    end_int <- strtoi(blocks_df$end[i], 16L)
    if (is.na(start_int) || is.na(end_int)) next
    if (cp_int >= start_int && cp_int <= end_int) {
      return(blocks_df$block_name[i])
    }
  }
  return(NA_character_)
}

assign_script <- function(cp, scripts_df) {
  cp_int <- strtoi(cp, 16L)
  if (is.na(cp_int)) return(NA_character_)
  for (i in 1:nrow(scripts_df)) {
    start_int <- strtoi(scripts_df$start[i], 16L)
    end_int <- strtoi(scripts_df$end[i], 16L)
    if (is.na(start_int) || is.na(end_int)) next
    if (cp_int >= start_int && cp_int <= end_int) {
      return(scripts_df$script[i])
    }
  }
  return(NA_character_)
}

# Add block and script to unicode_data (this will be slow on full dataset)
cat("Assigning blocks and scripts (this may take a while)...\n")
unicode_master <- unicode_data %>%
  mutate(
    block = sapply(code_point, assign_block, blocks_df = blocks),
    script = sapply(code_point, assign_script, scripts_df = scripts)
  )

head (unicode_master)



# Now expand ranges (skip CJK)
cat("Expanding character ranges (excluding CJK)...\n")
unicode_expanded <- unicode_master %>%   # CHANGED FROM unicode_data
  mutate(is_first = grepl(", First>", name),
         is_last = grepl(", Last>", name))




expanded_rows <- list()
i <- 1
while(i <= nrow(unicode_expanded)) {
  if(unicode_expanded$is_first[i]) {
    # Check if this is CJK (skip if so)
    if(grepl("CJK", unicode_expanded$name[i])) {
      i <- i + 2
      next
    }
    
    start_cp <- strtoi(unicode_expanded$code_point[i], 16L)
    end_cp <- strtoi(unicode_expanded$code_point[i+1], 16L)
    
    # Use the range marker's properties for all expanded characters
    template_row <- unicode_expanded[i,]
    for(cp in start_cp:end_cp) {
      new_row <- template_row
      new_row$code_point <- sprintf("%04X", cp)
      new_row$is_first <- FALSE
      new_row$is_last <- FALSE
      expanded_rows[[length(expanded_rows) + 1]] <- new_row
    }
    i <- i + 2
  } else if(!unicode_expanded$is_last[i]) {
    expanded_rows[[length(expanded_rows) + 1]] <- unicode_expanded[i,]
    i <- i + 1
  } else {
    i <- i + 1
  }
}

unicode_master <- bind_rows(expanded_rows) %>%
  select(-is_first, -is_last)

cat("Expanded to", nrow(unicode_master), "characters\n")
    

names(unicode_master)

# Write master database with version in filename
output_file <- paste0("UnicodeMaster_", unicode_version, ".txt")
write_delim(unicode_master, output_file, delim = ";")
cat("\nCreated", output_file, "\n")
cat("Total characters:", nrow(unicode_master), "\n")

