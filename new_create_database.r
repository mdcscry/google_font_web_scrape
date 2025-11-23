library(readr)
library(dplyr)

# Load the master database
unicode_version <- "17.0.0"
unicode_file_namer <- '17'
master_file <- paste0("UnicodeMaster_", unicode_version, ".txt")
unicode_db <- read_delim(master_file, delim = ";", col_types = cols(.default = "c"))

unique(unicode_db$category)

sort(unique(unicode_db$block))

# Load your manual exclusion file
source('./exclude_glyph.R')


# Filter out unwanted categories FULL BLOCK_HEX_No_Punct
  exclude_categories <- c("Cc","Zs","Po","Ps","Pe","Sm","Pd","Sk","Pc",
  "Pi","Cf","No","Pf","Lm","Mn","Me","Mc","Zl","Zp","Cs","Co"
  )
file_insert <- '_no_punct'



#Filter out unwanted categories FULL BLOCK_HEX
#  exclude_categories <- c("Cn", "Cf", "Mn", "Mc", "Me",
#                          "Cc", "Cs", "Co")
#  file_insert <- ''

fn <- paste0('block_hex',file_insert,'_',unicode_file_namer,'.js')
fn_desc <- paste0('block_hex_desc',file_insert,'_',unicode_file_namer,'.js')

cat(fn)
cat(fn_desc)

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

build_block_hex <- function(unicode_js_array_generator,fn) {
  #fn <- paste0('block_hex',file_insert,'_',unicode_file_namer,'.js')
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
  cat(paste0("\n\nconsole.log('",fn," is loaded');"), file=fn, append=TRUE)
  cat("\nvar blockHexWait = [];", file=fn, append=TRUE)
}

build_block_desc <- function(unicode_js_array_genner_desc,fn_desc) {
  #fn <- paste0('block_hex_desc',file_insert,'_',unicode_file_namer,'.js')
  if (file.exists(fn_desc)) file.remove(fn_desc)
  
  cat("block_hex_desc = {", file=fn_desc, sep="\n", append=TRUE)
  
  array_to_output <- c()
  for(i in 1:nrow(unicode_js_array_genner_desc)) {
    block <- unicode_js_array_genner_desc$block[i]
    list_of_desc <- unicode_js_array_genner_desc$glyph_desc[i]
    array_to_output[i] <- paste0("'", block, "' : ['", list_of_desc, "']")
  }
  
  cat(paste(array_to_output, collapse = ",\n"), file=fn_desc, sep="\n", append=TRUE)
  cat("\n}", file=fn_desc, append=TRUE)
  
  # Add footer
  cat(paste0("\n\nconsole.log('",fn_desc," is loaded');"), file=fn_desc, append=TRUE)
  cat("\nvar blockHexDescWait = [];", file=fn_desc, append=TRUE)
}

# Generate the files
build_block_hex(unicode_js_array_genner,fn)
build_block_desc(unicode_js_array_genner_desc,fn_desc)

cat("\nGenerated files:\n")
cat(paste0("- css_js/",fn,"\n"))
cat(paste0("- css_js/",fn_desc,"\n"))
cat("Total blocks:", nrow(unicode_js_array_genner), "\n")
cat("Total glyphs:", nrow(unicode_filtered), "\n")