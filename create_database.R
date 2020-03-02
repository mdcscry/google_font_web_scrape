library(dplyr)
library(lazyeval)
library(plyr)


mydir <- "./"
myfiles <- list.files(path=mydir, pattern="*.csv", full.names=TRUE)
myfiles


unicode_db = ldply(myfiles, read.csv,stringsAsFactors=FALSE)
str(unicode_db)
sort(unique(unicode_db$block))
dat_csv <-''

unicode_db[unicode_db$hex=='4DE9',]

list_of_gen_cat <- unique(unicode_db$gen_cat)
exclude_list <<-c("Unassigned",
                 'Format',
                 'Nonspacing_Mark','Spacing_Mark')

bejeebles <- function(unicode_db,exclude_list) {

  unicode_js_array_generator_all <- unicode_db %>% filter(!gen_cat %in% c("Unassigned",
                                                                           'Format',
                                                                           'Nonspacing_Mark','Spacing_Mark')
                                                           ) %>% 
  select(hex,glyph_script,glyph_desc,gen_cat,block)
  return(unicode_js_array_generator_all)
  
  }
unicode_js_array_generator_all <- bejeebles(unicode_db,exclude_list)
str(unicode_js_array_generator_all)
unique(unicode_js_array_generator_all$gen_cat)


#  Get Letters -----

letters_filter<-c("Other_Letter",
                  "Uppercase_Letter",
                  "Lowercase_Letter")

punct_filter <- c('Other_Punctuation','Close_Punctuation','Open_Punctuation','Dash_Punctuation',
                    'Connector_Punctuation','Initial_Punctuation','Final_Punctuation','Paragraph_Separator',
                    "Line_Separator")

numbers_filter <- c('Other_Number','Decimal_Number','Letter_Number')

letters_filter <- append( letters_filter, punct_filter )
letters_filter <- append( letters_filter, numbers_filter)

final_filter <- unique(unicode_js_array_generator_all$gen_cat)

unicode_letters <- unicode_js_array_generator_all[ unicode_js_array_generator_all$gen_cat %in% final_filter,]
str(unicode_letters)
unique(unicode_letters$gen_cat)
unique(unicode_letters$block)


source('./exclude_glyph.R')

# Eliminate Blocks ----
#exclude_blocks=c()
unicode_letter_block_reduce <- unicode_letters[!unicode_letters$block %in% exclude_blocks,]
str(unicode_letter_block_reduce)
sort(unique(unicode_letter_block_reduce$block))

# Eliminate Glyphs ----
#exclude_glyph <- c()
unicode_letters_glyhp_reduce <- unicode_letter_block_reduce[!unicode_letter_block_reduce$hex %in% exclude_glyph,]
str(unicode_letters_glyhp_reduce)
unique(unicode_letters_glyhp_reduce$gen_cat)

final_set <- unicode_letters_glyhp_reduce

  
unicode_js_array_genner <- aggregate(hex ~ block, data = final_set, paste, collapse = "','")
unicode_js_array_genner_desc <- aggregate(glyph_desc ~ block, data = final_set, paste, collapse = "','")

str(unicode_js_array_genner)
str(unicode_js_array_genner_desc)

###  Build block_hex-----
build_block_hex <-function(unicode_js_array_generator){
    fn <- 'block_hex.js'
    if (file.exists(fn)) 
      file.remove(fn)
    
    #cut a fresh blocks array
    blocks <- paste0( 
      "blocks = ['",paste0(unicode_js_array_generator$block, collapse="','"),"'];"
    )
    cat(blocks,file=fn,sep="\n\n",append = TRUE)
    
    cat("block_hex = {",file=fn,sep="\n\n", append = TRUE)
    array_to_output <- ''
    
    for( i in #start_of_block:depth_of_block#
         rownames(unicode_js_array_generator) 
         ){
      
      block <- unicode_js_array_generator[i, "block"]
      list_of_hex <- unicode_js_array_generator[i, "hex"]
      array_to_output <- paste0(array_to_output,"'",block,"' : ['",list_of_hex,"'],\n")
    }
    cat(array_to_output,file=fn,sep="\n\n",append = TRUE)
    cat("}",file=fn,append=TRUE)
}

unique(unicode_db$block)
start_of_block <<-221
depth_of_block <<- 285
build_block_hex(unicode_js_array_genner)
build_block_hex_desc(unicode_js_array_genner_desc)






###  Build block_hex_desc-----
build_block_hex_desc <- function(unicode_js_array_generator){
  fn <- 'block_hex_desc.js'
  if (file.exists(fn)) 
    file.remove(fn)
  
  cat("block_hex_desc = {",file=fn,sep="\n\n", append = TRUE)
  array_to_output <- ''
  for( i in # start_of_block:depth_of_block #
       rownames(unicode_js_array_generator) 
  ){
    
    block <- unicode_js_array_generator[i, "block"]
    list_of_hex_desc <- unicode_js_array_generator[i, "glyph_desc"]
    array_to_output <- paste0(array_to_output,"'",block,"' : ['",list_of_hex_desc,"'],\n")
  }
  cat(array_to_output,file=fn,sep="\n\n",append = TRUE)
  cat("}",file=fn,append=TRUE)
}
build_block_hex_desc(unicode_js_array_genner_desc)


###  Build block_lang_skeleton.js-----
build_block_lang_skeleton <- function(unicode_js_array_generator){
  fn <- 'block_lang_skeleton.js'
  if (file.exists(fn)) 
    file.remove(fn)
  
  
  for( i in rownames(unicode_js_array_generator) ){
    
    block <- unicode_js_array_generator[i, "block"]
    array_to_output <- paste0("var block_lang['",block,"'] = [''];")
    cat(array_to_output,file=fn,sep="\n\n",append = TRUE)
    
  }
}
#build_block_lang_skeleton(unicode_js_array_genner_desc)




