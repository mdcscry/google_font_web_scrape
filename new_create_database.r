library(readr)
library(dplyr)

# Load the master database
unicode_version <- "17.0.0"
master_file <- paste0("UnicodeMaster_", unicode_version, ".txt")
unicode_db <- read_delim(master_file, delim = ";", col_types = cols(.default = "c"))

unique(unicode_db$category)
sort(unique(unicode_db$block))

# Load your manual exclusion file
source('./exclude_glyph.R')

# Filter out unwanted categories
exclude_categories <- c("Cn", "Cf", "Mn", "Mc", "Me",
                        "Cc", "Cs", "Co")

# Filter the data
unicode_filtered <- unicode_db %>%
  filter(!category %in% exclude_categories) %>%
  filter(!block %in% exclude_blocks) %>%
  filter(!code_point %in% exclude_glyph) %>%
  select(all_of(c("code_point", "name", "category", "block", "script")))

sort(unique(unicode_filtered$block))

# Aggregate by block
unicode_js_array_genner <- aggregate(code_point ~ block, 
                                     data = unicode_filtered, 
                                     FUN = function(x) paste(x, collapse = "','"))
names(unicode_js_array_genner)[2] <- "hex"

unicode_js_array_genner_desc <- aggregate(name ~ block, 
                                          data = unicode_filtered, 
                                          FUN = function(x) paste(x, collapse = "','"))
names(unicode_js_array_genner_desc)[2] <- "glyph_desc"

build_block_hex <- function(unicode_js_array_generator) {
  fn <- 'block_hex_17.js'
  if (file.exists(fn)) file.remove(fn)
  
  # Create blocks array
  blocks <- paste0("blocks = ['", paste0(unicode_js_array_generator$block, collapse="','"), "'];")
  cat(blocks, file=fn, sep="\n\n", append=TRUE)
  
  # Create block_hex object
  cat("block_hex = {", file=fn, sep="\n\n", append=TRUE)
  
  array_to_output <- c()
  for(i in 1:nrow(unicode_js_array_generator)) {
    block <- unicode_js_array_generator$block[i]
    list_of_hex <- unicode_js_array_generator$hex[i]
    array_to_output[i] <- paste0("'", block, "' : ['", list_of_hex, "']")
  }
  
  # Join with commas, no trailing comma
  cat(paste(array_to_output, collapse = ",\n"), file=fn, sep="\n", append=TRUE)
  cat("\n}", file=fn, append=TRUE)
  
  # Add footer
  cat("\n\nconsole.log('Block Hex_17.js is loaded');", file=fn, append=TRUE)
  cat("\nvar blockHexWait = [];", file=fn, append=TRUE)
}

build_block_desc <- function(unicode_js_array_genner_desc) {
  fn <- 'block_hex_desc_17.js'
  if (file.exists(fn)) file.remove(fn)
  
  cat("block_hex_desc = {", file=fn, sep="\n", append=TRUE)
  
  array_to_output <- c()
  for(i in 1:nrow(unicode_js_array_genner_desc)) {
    block <- unicode_js_array_genner_desc$block[i]
    list_of_desc <- unicode_js_array_genner_desc$glyph_desc[i]
    array_to_output[i] <- paste0("'", block, "' : ['", list_of_desc, "']")
  }
  
  cat(paste(array_to_output, collapse = ",\n"), file=fn, sep="\n", append=TRUE)
  cat("\n}", file=fn, append=TRUE)
  
  # Add footer
  cat("\n\nconsole.log('Block Hex_Desc_17.js is loaded');", file=fn, append=TRUE)
  cat("\nvar blockHexDescWait = [];", file=fn, append=TRUE)
}

# Generate the files
build_block_hex(unicode_js_array_genner)
build_block_desc(unicode_js_array_genner_desc)

cat("\nGenerated files:\n")
cat("- css_js/block_hex_17.js\n")
cat("- css_js/block_hex_desc_17.js\n")
cat("Total blocks:", nrow(unicode_js_array_genner), "\n")