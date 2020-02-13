library(dplyr)
library(lazyeval)

mydir <- "./"
myfiles <- list.files(path=mydir, pattern="*.csv", full.names=TRUE)
myfiles


unicode_db = ldply(myfiles, read.csv,stringsAsFactors=FALSE)
str(unicode_db)
dat_csv <-''
list_of_gen_cat <- unique(unicode_db$gen_cat)
exclude_list <-c("Unassigned",
                 'Format',
                 'Nonspacing_Mark')

bejeebles <- function(unicode_db,exclude_list) {

  unicode_js_array_generator_all <- unicode_db %>% filter(!gen_cat %in% c("Unassigned",
                                                                           'Format',
                                                                           'Nonspacing_Mark')
                                                           ) %>% 
  select(hex,glyph_script,glyph_desc,gen_cat,block)
  return(unicode_js_array_generator_all)
  
  }
unicode_js_array_generator_all <- bejeebles(unicode_db,exclude_list)

unique(unicode_js_array_generator_all$gen_cat)
  
unicode_js_array_genner <- aggregate(hex ~ block, data = unicode_js_array_generator_all, paste, collapse = "','")
unicode_js_array_genner_desc <- aggregate(glyph_desc ~ block, data = unicode_js_array_generator_all, paste, collapse = "','")

str(unicode_js_array_genner)
str(unicode_js_array_genner_desc)

###  Build block_hex-----
build_block_hex <- function(unicode_js_array_generator){
    fn <- 'block_hex.js'
    if (file.exists(fn)) 
      file.remove(fn)
    
    blocks <- paste0( 
      "blocks = ['",paste0(unicode_js_array_generator$block, collapse="','"),"'];"
    )
    cat(blocks,file="./block_hex.js",sep="\n\n",append = TRUE)
    
    
    for( i in rownames(unicode_js_array_generator) ){
      
      block <- unicode_js_array_generator[i, "block"]
      list_of_hex <- unicode_js_array_generator[i, "hex"]
      array_to_output <- paste0("var block_hex['",block,"'] = ['",list_of_hex,"'];")
      cat(array_to_output,file="./block_hex.js",sep="\n\n",append = TRUE)
    
    }
}
build_block_hex(unicode_js_array_genner)

###  Build block_hex-----
build_block_hex_desc <- function(unicode_js_array_generator){
  fn <- 'block_hex_desc.js'
  if (file.exists(fn)) 
    file.remove(fn)
  
  
  for( i in rownames(unicode_js_array_generator) ){
    
    block <- unicode_js_array_generator[i, "block"]
    list_of_hex_desc <- unicode_js_array_generator[i, "glyph_desc"]
    array_to_output <- paste0("var block_hex_desc['",block,"'] = ['",list_of_hex_desc,"'];")
    cat(array_to_output,file="./block_hex_desc.js",sep="\n\n",append = TRUE)
    
  }
}
build_block_hex_desc(unicode_js_array_genner_desc)

