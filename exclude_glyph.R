


exclude_blocks <- c(
  'Alphabetic Presentation Forms'
  ,'Ideographic Symbols And Punctuation'
  ,'Kana Extended-A'
  ,'Kana Extended-B'  
  ,'Kana Supplement'
  ,'Small Kana Extension'
  ,'Syriac Supplement'
  
  #for display
  ,'Combining Diacritical Marks Extended'
  ,'Combining Diacritical Marks For Symbols'
  ,'Control Pictures'
  ,'Enclosed Alphanumeric Supplement'
  ,'Enclosed Alphanumerics'
  ,'Enclosed CJK Letters And Months'
  ,'Ideographic Description Characters'
  ,'Ideographic Symbols and Punctuation'  
  ,'Enclosed Ideographic Supplement'
  ,'CJK Compatibility'  
  ,'CJK Compatibility Forms'
  ,'CJK Unified Ideographs'
  ,'CJK Compatibility Ideographs Supplement'
  ,'CJK Compatibility Ideographs'
  ,'CJK Unified Ideographs Extension A'
  ,'CJK Unified Ideographs Extension B'
  ,'CJK Unified Ideographs Extension C'
  ,'CJK Unified Ideographs Extension D'
  ,'CJK Unified Ideographs Extension E'
  ,'CJK Unified Ideographs Extension F'
  ,'CJK Unified Ideographs Extension G'
  ,'Halfwidth and Fullwidth Forms' 
  ,'Small Form Variants'
  ,'Small Kana Extension'
  ,'Kana Extended-B' 
  ,'Cyrillic Extended-D'
  ,'Garay'
  ,'Tulu-Tigalari'
  ,'Myanmar Extended-C'
  ,'Egyptian Hieroglyphs Extended-A'
  ,'Egyptian Hieroglyph Format Controls'
  ,'Gurung Khema' # look at this one
  ,'Kirat Rai'
  ,'Ol Onal' #look at this one
  ,'Sidetic'
  ,'Sharada Supplement'
  ,'Tolong Siki'
  ,'Beria Erfe'
  ,'Tangut Components Supplement'
  ,'Miscellaneous Symbols Supplement'
  ,'Tai Yo'
  ,'Symbols for Legacy Computing Supplement'
  ,'Specials'
  ,'Arabic Extended-C'
  ,'Hangul Jamo Extended-A'
  ,'Hangul Jamo Extended-B'  
  ,'Hangul Syllables'  
);


exclude_glyph <- c(
  
#alchemical symbols  
'1F778','1F779','1F77A'

#anatolian heiroglyphics
,'14524'
  
#arabic extended-A & B ( C block is removed )
,'08BA','08BF','08C0','08C1','08C2','08C3','08C4','08C5','08C6','08C7','08C9','088F'

#arabic presentation forms A
,'FBC3','FBC4','FBC5','FBC6','FBC7','FBC8','FBC9','FBCA','FBCB','FBCC','FBCD','FBCE','FBCF','FBD0','FBD1','FBD2','FD90','FD91','FDC8','FDC9','FDCA','FDCB','FDCC','FDCD','FDCE'

#balinese
,'1B4C','1B4E','1B4F','1B7D','1B7E','1B7F'

#basic latin
,'0020'

#bengali
,'09FC' #is rendered by noto sans and serif as well as others.

#bopmofo extended
,'31BC','31BD','31BE','31BF'

#chess symbols
,'1FA54','1FA55','1FA56','1FA57'

#CJK Strokes
,'31D0','31D1','31D2','31D3','31D4','31D5','31D6','31D7','31D8','31D9','31DA','31DB','31DC','31DD','31DE','31DF','31E0','31E1','31E2','31E3','31E4','31E5','31EF'

#Currency Symbols
,'20C1'

#Cyrillic Extended-C
,'1C89','1C8A'

#Dives Akuru
,'11901','11903','11905','1190D','1190F','11911','11912','11913','11915','1192A','11941','11950','11951','11952','11953','11954','11955','11956','11957','11958','11959'

#Enclosed_Ideographic_Supplement
,'1F263','1F262','1F264','1F260','1F265','1F243','1F261','1F226','1F22E','1F22C','1F223','1F210'

#Enclosed CJK Letters and Months
,'32CC','32CD','32CE','32CF'

#General Punctuation
,'2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','200A','2028','2029','202F','205F'

#Geometric Shapes Extended
,'1F7E0','1F7E1','1F7E2','1F7E3','1F7E4','1F7E5','1F7E6','1F7E7','1F7E8','1F7E9','1F7EA','1F7EB','1F7F0'

#Glagolitic
,'2C5F'

#gurmukhi
,'0A76'

#hebrew
,'05EF'

#hangul jamo
,'115A','115B','115C','115D','115E','115F','1160','11A3','11A4','11A5','11A6','11A7','11FA','11FB','11FC','11FD','11FE','11FF'

#Kana Extended-A
,'1B11F'

#Katakana Phonetic Extensions
,'31FF'

#Khitan Small Script
,'18CFF'

#Latin Extended-D
,'A7CB','A7CC','A7CD','A7CE','A7CF','A7D2','A7D4','A7DA','A7DB','A7DC','A7F1'

#Latin Extended-G
,'1DF25','1DF26','1DF27','1DF28','1DF29','1DF2A'

#Latin-1 Supplement
,'00A0'

#Malayalam
,'0D4E'

#Miscellaneous_Symbols (These all render in Symbola but are emojis)
,'2614','261D','267F','26A1','26AA','26AB','26BD','26BE','26C4','26C5','26D4'

#Miscellaneous_Technical (These all render in Symbola but are emojis)
,'231A','231B','23E9','23EA','23EB','23EC','23F0','23F3'

#Newa
,'11460','11461'

#Runic
,'16F1','16F2','16F3','16F4','16F5','16F6','16F7','16F8'

#sharada
,'111C3','111C2'

#soyombo
,'11A84','11A85','11A86','11A87','11A88','11A89'

#Supplemental Arrows-C
,'1F8AC','1F8AD','1F8B2','1F8B3','1F8B4','1F8B5','1F8B6','1F8B7','1F8B8','1F8B9','1F8BA','1F8BB','1F8C0','1F8C1','1F8D0','1F8D1','1F8D2','1F8D3','1F8D4','1F8D5','1F8D6','1F8D7','1F8D8'

#Supplemental_Symbols_And_Pictographs no glyph
,'1F3FB','1F3FC','1F3FD','1F3FE','1F3FF' #skin
,'1F9B0','1F9B1','1F9B2','1F9B3','1F9B3' #hair

#Symbols for Legacy Computing
,'1FBCB','1FBCC','1FBCD','1FBCE','1FBCF','1FBD0','1FBD1','1FBD2','1FBD3','1FBD4','1FBD5','1FBD6','1FBD7','1FBD8','1FBD9','1FBDA','1FBDB','1FBDC','1FBDD','1FBDE','1FBDF'
,'1FBE0','1FBE1','1FBE2','1FBE3','1FBE4','1FBE5','1FBE6','1FBE7','1FBE8','1FBE9','1FBEA','1FBEB','1FBEC','1FBED','1FBEE','1FBEF'


#Tangut
,'187F8','187F9','187FA','187FB','187FC','187FD','187FE','187FF'

#Tangut Supplement
,'18D09','18D0A','18D0B','18D0C','18D0D','18D0E','18D0F','18D10','18D11','18D12','18D13','18D14','18D15','18D16','18D17','18D18','18D19','18D1A','18D1B','18D1C','18D1D','18D1E'

#Telegu
,'0C5C'

#Tibetan
,'0FD9','0FDA'

#Vedic_Extensions
 ,'1CFA'

)

