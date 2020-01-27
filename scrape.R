library(rvest)



dabiz <- function(){
    # create list of glyphs----
    dabiz <- "['20"
    for(i in seq(from=strtoi("0x10980"), to=strtoi("0x109FF"), by=1)) {
      #    print (i)
      #print(sprintf("%x",i))
      dabiz <- paste0(dabiz,"','", sprintf("%x",i))
    }
    dabiz <- paste0(dabiz,"']")
    print (dabiz)
    
    for(i in seq(from=1, to=78, by=2)){
      #  stuff, such as
      print(i)
    }
    
    # Select all Early Access Fonts----
    googfonthtml<- read_html("https://fonts.google.com/earlyaccess")
    googfonthtml %>%
      html_node(xpath="/html/body/main/div/div/div[1]/ol/li[node()]/pre[1]")%>%
      html_text()
    
    indecision <- c()
    
    for(i in 1:150){
      #print("in")
      
      xpathvar <- paste0("/html/body/main/div/div/div[1]/ol/li[", i ,"]/pre[1]" )
      
      googfonthtml %>%
        html_node(xpath=xpathvar)%>%
        html_text() -> tmp
        indecision <- c(indecision,tmp)
    }
    indecision
    #should get 144
}
#########################################  build url ----


build_url <- function(start,end) {
  db_build_url <- c()
  
    for(i in strtoi(start):strtoi(end)){
    ##check dupes 216
      buildUrl <- paste0("https://unicode.org/cldr/utility/character.jsp?a=", sprintf("%x",i))
      db_build_url <- c(db_build_url,buildUrl)
    }
  
  return (db_build_url)
}

build_failure_url <- function(list) {
  db_build_url <- c()
  
  for(i in list){
    ##check dupes 216
    buildUrl <- paste0("https://unicode.org/cldr/utility/character.jsp?a=", sprintf("%x",i))
    db_build_url <- c(db_build_url,buildUrl)
  }
  
  return (db_build_url)
}


get_data <- function(unicode_db,db_build_url){

  for (url in db_build_url){
      tryCatch({
        glyphdtl <- read_html(url) 

        tmp <- data.frame(glyph=html_node(glyphdtl,xpath="/html/body/div/div/table/tr[1]/td") %>% html_text(),
                  hex=html_node(glyphdtl,xpath="/html/body/div/div/table/tr[2]/td") %>% html_text(),
                  glyph_desc= html_node(glyphdtl,xpath="/html/body/div/div/table/tr[3]/td") %>% html_text() ,
                  glyph_script= html_node(glyphdtl,xpath="/html/body/div/div/table/tr[4]/td") %>% html_text(), 
                  alnum = html_node(glyphdtl,xpath="//a[contains(@href,':alnum')]") %>% html_text() ,
                  alphabetic = html_node(glyphdtl,xpath="//a[contains(@href,':Alphabetic')]") %>% html_text(), 
                  block = html_node(glyphdtl,xpath="//a[contains(@href,':Block')]") %>% html_text(),
                  gen_cat = html_node(glyphdtl,xpath="//a[contains(@href,':General_Category')]") %>% html_text(),
                  indic_syl_cat = html_node(glyphdtl,xpath="//a[contains(@href,':Indic_Syllabic_Category')]") %>% html_text() ,
                  script = html_node(glyphdtl,xpath="//a[contains(@href,':Script')]") %>% html_text() ,
                  script_extent = html_node(glyphdtl,xpath="//a[contains(@href,':Script_Extensions')]") %>% html_text(),
                  ascii = html_node(glyphdtl,xpath="//a[contains(@href,':ASCII')]") %>% html_text(),
                  basic_emoji = html_node(glyphdtl,xpath="//a[contains(@href,':Basic_Emoji')]") %>% html_text(),
                  canon_combine_form = html_node(glyphdtl,xpath="//a[contains(@href,':Canonical_Combining_Class')]") %>% html_text(),
                  cjk_radical = html_node(glyphdtl,xpath="//a[contains(@href,':CJK_Radical')]") %>% html_text(),
                  default_ignorable = html_node(glyphdtl,xpath="//a[contains(@href,':Default_Ignorable_Code_Point')]") %>% html_text(),
                  diacritic = html_node(glyphdtl,xpath="//a[contains(@href,':Diacritic')]") %>% html_text(),
                  emoji = html_node(glyphdtl,xpath="//a[contains(@href,':Emoji')]") %>% html_text(),
                  equiv_uni_ideo = html_node(glyphdtl,xpath="//a[contains(@href,':Equivalent_Unified_Ideograph')]") %>% html_text(),
                  ext_picto = html_node(glyphdtl,xpath="//a[contains(@href,':Extended_Pictographic')]") %>% html_text(),
                  hangul_syl_type = html_node(glyphdtl,xpath="//a[contains(@href,':Hangul_Syllable_Type')]") %>% html_text(),
                  hantype = html_node(glyphdtl,xpath="//a[contains(@href,':HanType')]") %>% html_text(),
                  ideograph = html_node(glyphdtl,xpath="//a[contains(@href,':Ideographic')]") %>% html_text(),
                  math = html_node(glyphdtl,xpath="//a[contains(@href,':Math')]") %>% html_text(),
                  nonchar_code_point = html_node(glyphdtl,xpath="//a[contains(@href,':Noncharacter_Code_Point')]") %>% html_text(),
                  radical = html_node(glyphdtl,xpath="//a[contains(@href,':Radical')]") %>% html_text(),
                  pattern_white_space = html_node(glyphdtl,xpath="//a[contains(@href,':Pattern_White_Space')]") %>% html_text(),
                  unified_ideograph = html_node(glyphdtl,xpath="//a[contains(@href,':Unified_Ideograph')]") %>% html_text(),
                  white_space = html_node(glyphdtl,xpath="//a[contains(@href,':White_Space')]") %>% html_text()
                )
        
        unicode_db <- rbind(unicode_db, tmp)
        print(paste0(url,' is complete.'))
        
      }, warning = function(w) {
        print(w)
        print(paste0(url,' did not complete and was added to failures'))
        return()
  
      }, error = function(e) {
        print(e)
        print(paste0(url,' did not complete and was added to failures'))
        return()
      }
    )
    
  }
  return(unicode_db)
}  

###  writeTable  ----

write_data <- function (unicode_db){
 # Add Decimal ---- 
  unicode_db['decimal'] <-apply(unicode_db['hex'],1,function(x) strtoi(paste0('0x',x)))
  attach (unicode_db)
  unicode_db <- unicode_db[order(decimal),]

  write.table(unicode_db, file = "unicode_db.csv",
          col.names = TRUE, 
          row.names = FALSE,
          sep=","
          
          )
print("Table is written.")
}


#  Call the Main Functions ----
# prepare saved datafile for new rows
main_function <- function(start,end){
  unicode_db <- read.csv("unicode_db.csv")
  #unicode_db <- data.frame()
  unicode_db <- subset(unicode_db, select = -c(decimal))


  get_data_return <-get_data(unicode_db,build_url(start,end))

  unicode_db <- get_data_return
  return(unicode_db)
}
#unicode_db <- main_function('0x5c01','0x6000')
#tail(unicode_db)
#write_data(unicode_db)


# run failures ----

unicode_db <- fix_failures()
tail(unicode_db)


write_data(unicode_db)

fix_failures <- function(){
    # prepare saved datafile for new rows
    unicode_db <- read.csv("unicode_db.csv")
    failures <- list(setdiff(seq(12289,24576,1),unicode_db$decimal))
    unicode_db <- subset(unicode_db, select = -c(decimal))
    

    get_data_return_fail <-get_data(unicode_db,build_failure_url(failures))
    tail(get_data_return_fail,15)
    unicode_db <- get_data_return_fail
    tail(unicode_db,15)
    return(unicode_db)
    
}  
    
    
    
