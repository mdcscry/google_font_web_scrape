library(rvest)
library(stringr)


dabiz <- function(){
    # create list of glyphs----
    dabiz <- "['20"
    for(i in seq(from=strtoi("0x16800"), to=strtoi("0x16a3f"), by=1)) {
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

write_data <- function (unicode_db,file = "unicode_db.csv"){
 # Add Decimal ---- 
  unicode_db['decimal'] <-apply(unicode_db['hex'],1,function(x) strtoi(paste0('0x',x)))
  attach (unicode_db)
  unicode_db <- unicode_db[order(decimal),]

  write.table(unicode_db, file = file,
          col.names = TRUE, 
          row.names = FALSE,
          sep=","
          
          )
print("Table is written.")
}


#  Call the Main Functions ----
# prepare saved datafile for new rows
main_function <- function(start,end,file){
  unicode_db <- read.csv(file)
  #unicode_db <- data.frame()
  unicode_db <- subset(unicode_db, select = -c(decimal))

  get_data_return <-get_data(unicode_db,build_url(start,end))

  unicode_db <- get_data_return
  return(unicode_db)
} 

fix_failures <- function(start,end,file){
  # prepare saved datafile for new rows
  unicode_db <- read.csv(file)
  failures <- list(setdiff(seq(start,end,1),unicode_db$decimal))
  unicode_db <- subset(unicode_db, select = -c(decimal))
  #print(failures)
  print(length(failures[[1]]))
  i <- 0
  while ((length(failures[[1]]) >0)&&(i < 4)){
    get_data_return_fail <- get_data(unicode_db,build_failure_url(failures))
    tail(get_data_return_fail,15)
    unicode_db <- get_data_return_fail
    tail(unicode_db,15)
    write_data(unicode_db,file)
    unicode_db <- read.csv(file)
    failures <- list(setdiff(seq(start,end,1),unicode_db$decimal))
    unicode_db <- subset(unicode_db, select = -c(decimal))
    print (failures)
    i <- i+1
  }  
  return(unicode_db)
  
}  






##unicode_db_1d000_1d24f.csv
    #Musical Symbols
    #Ancient Greek Musical Notation
##unicode_db_1d2e0_1daaf.csv 
    #Mayan Numerals
    #Tai Xuan Jing Symbols  
    #Counting Rod Numerals
    #Mathematical Alphanumeric Symbols
    #Sutton SignWriting
##unicode_db_1e000_1e02f.csv #glaglitic supplement
##unicode_db_1e100_1e14f.csv #Nyiakeng Puachue Hmong
##unicode_db_1e2c0_1e2ff.csv #wancho
##unicode_db_1e800_1e8df.csv #Mende Kikakui
##unicode_db_1e900_1e95f.csv	Adlam
##unicode_db_1ec70_1ecbf.csv	Indic Siyaq Numbers
##unicode_db_1ed00_1ed4f.csv	Ottoman Siyaq Numbers
##unicode_db_1ee00_1eeff.csv	Arabic Mathematical Alphabetic Symbols
##unicode_db_1f000_1f02f.csv	Mahjong Tiles


##unicode_db_1f030_1f09f.csv	Domino Tiles
##unicode_db_1f0a0_1f0ff.csv	Playing Cards
##unicode_db_1f100_1f1ff.csv	Enclosed Alphanumeric Supplement
##unicode_db_1f200_1f2ff.csv	Enclosed Ideographic Supplement
##unicode_db_1f300_1f5ff.csv	Miscellaneous Symbols and Pictographs
##unicode_db_1f600_1f64f.csv	Emoticons

##unicode_db_1f650_1f67f.csv	Ornamental Dingbats
##unicode_db_1f680_1f6ff.csv	Transport and Map Symbols
##unicode_db_1f700_1f77f.csv	Alchemical Symbols
##unicode_db_1f780_1f7ff.csv	Geometric Shapes Extended
##unicode_db_1f800_1f8ff.csv	Supplemental Arrows-C
##unicode_db_1f900_1f9ff.csv	Supplemental Symbols and Pictographs
##unicode_db_1fa00_1fa6f.csv	Chess Symbols
##unicode_db_1fa70_1faff.csv	Symbols and Pictographs Extended-A

########Pre unicode 12
#list_of_blocks <- c('0021_3000')
#list_of_blocks <- c('3001_6000') #includeds cjk A
# list_of_blocks <- c('1b000_1b2ff',1bc00_1bc9f','1d000_1d24f',
#                     '1d2e0_1d2ff',
#                     '1d300_1d37f',
#                     '1d400_1d7ff',
#                     '1d800_1daaf',
#                     '1e000_1e02f','1e100_1e14f','1e2c0_1e2ff','1e800_1e8df',
#                     '1d800_1daaf')
# list_of_blocks <- c('1e900_1e95f','1ec70_1ecbf','1ed00_1ed4f','1ee00_1eeff','1f000_1f02f','1f030_1f09f'
#                     ,'1f0a0_1f0ff','1f100_1f1ff'
#                     ,'1f200_1f2ff','1f300_1f64f','1f650_1f67f','1f680_1f6ff','1f700_1f77f',
#                     '1f780_1f7ff',
#                     '1f800_1f8ff',
#                     '1f900_1f9ff',
#                     '1fa00_1fa6f',
#                     '1fa70_1faff')
# list_of_blocks <- c('6001_6300','6801_6a00','6a01_6c00','6c01_6fff','6701_6800'
#                     ,'7000_7300','7301_7600','7601_7700','7701_7a00','7a01_7c00','7c01_7fff'
#                     ,'8000_8300','8301_8400','8401_8500','8501_8600','8601_8800','8301_8400')
# list_of_blocks <- c('8801_8a00','8a01_8c00','8c01_8d00','8d01_8e00','8e01_8f00','8f01_8fff'
#                     ,'9000_9200','9201_9300','9301_9400','9401_9500'
#                     ,'9501_9700','9701_9800','9801_9900','9901_9a00','9a01_9c00','9c01_9d00'
#                     ,'9d01_9e00','9e01_9f00','9f01_a000')
#list_of_blocks <- c('10000_12541','13000_1343f','14400_1467f')
#list_of_blocks <- c('16800_16fff','17000_18aff','a001_d000','d001_d7ff','f900_ffef')

#list_of_blocks<- c('20000_2a6df') #cjk extended B
list_of_blocks<- c('2b740_2b81f','2ceb0_2ebef') #cjk extended D,F
#list_of_blocks <-c(,'2a700_2b73f','2b820_2cead'). #cjk extended c,e

#######

####### Unicode 13
#Chorasmian
#list_of_blocks <- c('10fb0_10fcb')
#Symbols for Legacy Computing
#list_of_blocks <- c('1fb00_1fb92','1fb94_1fbca','1fbf0_1fbf9')
#Dives Akuru
#list_of_blocks <- c('11900_11959')

#400 khitan small script + tangut supplement
#list_of_blocks <- c('18b00_18D08') 

#4939 CJK extended G
##########list_of_blocks <- c('30000_3134a')---CJK !!!!!!

######Unicode 14
#cypro_minoan,kana_extended_b,znammeny_musical_notation,latin_extended_d,toto,ethiopic_extended_b
#list_of_blocks <- c('12f90_12fff','1aff0_1afff','1cf00_1cfcf','1df00_1dfff','1e290_1e2bf','1e7e0_1e7ff')


######Unicode 15
#Kaktovik Numerals,cyrillic_extended_d,Nag Mundari
#list_of_blocks <- c('1d2c0_1d2df','1e030_1e08f','1e4d0_1e4ff') #9/30
#list_of_blocks <- c('31350_323af') #CJK Unified Ideographs Extension H 4000+ char

#####Unicode 15.1
#CJK_Unified_Ideographs_Extension_I
#list_of_blocks <- c('2ebf0_2ee5d').  #9/30

#####Unicode 16
#Egyptian_Hieroglyphs_Extended_A
#list_of_blocks <-c('13460_143ff')
#Gurung_Khema,Symbols_for_Legacy_Computing_Supplement,Ol_Onal
#list_of_blocks<-c('16100_1613f','1cc00_1cebf','1e5d0_1e5ff')  #9/30

#####Unicode 17
#Beria_Erfe, Tangut_Components_Supplement,Miscellaneous_Symbols_Supplement,Tai_Yo
#list_of_blocks <-c('16ea0_16edf','18d80_18dff','1cec0_1ceff','1e6c0_1e6ff') #9/30

#CJK Unified Ideographs Extension J
#list_of_blocks <- c('323b0_33479') #CJK !!!!!!

for (block in list_of_blocks){
 # current_main <-paste0('unicode_db_',3000,'.csv')
  current_main <-paste0('unicode_db_',block,'.csv')
  file.create(current_main)
  system(paste0("head -n1 unicode_db_3000.csv > " ,current_main))

  main_start <- paste0('0x',str_split(block,'_')[[1]][1])  
  main_end <- paste0('0x',str_split(block,'_')[[1]][2])
  unicode_db <- main_function(main_start,main_end,current_main)
  
  tail(unicode_db) 
  write_data(unicode_db,current_main)


  # run failures ----
  start <- strtoi(main_start)
  end <- strtoi(main_end)
  currentfixer <- current_main
  unicode_db <- fix_failures(start,end,currentfixer)
  tail(unicode_db)
  write_data(unicode_db,currentfixer)

}    








    
