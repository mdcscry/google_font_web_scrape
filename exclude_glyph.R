


exclude_blocks <- c(
  'Chess_Symbols'
  ,'Georgian_Extended'
  ,'Ideographic_Symbols_And_Punctuation'
  ,'Kana_Extended_A','Kana_Supplement'
  ,'Makasar'
  ,'Medefaidrin'
  ,'Mongolian_Supplement'
  ,'Nandinagari'
  ,'Nushu'
  ,'Nyiakeng_Puachue_Hmong'
  ,'Ottoman_Siyaq_Numbers'
  ,'Small_Kana_Extension'
  ,'Sutton_SignWriting'
  ,'Symbols_And_Pictographs_Extended_A'
  ,'Syriac_Supplement'
  ,'Tamil_Supplement'
  
  #for display
  ,'Combining_Diacritical_Marks_Extended'
  ,'Combining_Diacritical_Marks_For_Symbols'
  ,'Control_Pictures'
  ,'Enclosed_Alphanumeric_Supplement'
  ,'Enclosed_Alphanumerics'
  ,'Enclosed_CJK_Letters_And_Months'
  ,'Ideographic_Description_Characters'
  ,'Block_Elements'
  ,'Supplemental_Symbols_And_Pictographs'
  
  
);


exclude_glyph <- c(
#aegean
'1012D'

#adlam
,'1E94B'

#armenian
,'0560','0588','0569'

#arrow
,'21D9'

#bengali
,'09FD','09FC'

#chakma
,'11144','11126'

#cherokee
,'13EE'

#box drawing
,'251B','2599'

#cjk compatibility

,'332C','FA41','F921','F94C'
,'FA6C'
,'FA70','FA73','FA77','FA76'
, 'FA82','FA84','FA85','FA86','FA87', 'FA89','FA8C'
, 'FA90', 'FA91', 'FA92','FA93','FA94','FA95','FA96','FA97','FA9C','FA9D','FA9E','FA9F'
, 'FAA1','FAA4', 'FAAC'
, 'FAB0','FAB2','FAB5','FAB6','FAB7', 'FABD','FABE'
, 'FAC0','FAC1','FAC2','FAC3','FAC5', 'FAC7','FAC9','FACB','FACD'
, 'FAD2', 'FAD3','FAD4','FAD5','FAD8'
, 'F9A3','F9C6', 'F931','F91D','F9D7'
,'FAAD','FACA','FABA','F96B','FABB','FA9B','FAC8','FA7A','FAA8','FA8C','FA9C'
,'F941','F933','FAB1','F910','FA83','FA71','F905','FAA2','FA65','FA7D','FAAB','FA99'
,'F992','FAD8','FA7E','FABC','F9F6','FAD5','FA40','FA10','FAA3','FA07','F90D','FAD0'
,'FA88','FA78','FAD6','FA39','FAD1','FAB3','FA29','FAAF','FA8B','FAA6','FAD9'
,'FAB0','FACE','FA64','FACF','FA7C','FA51','F984','FAAA','FA72','FAB4','FA4E'
,'FA74','FAC4','F963','F9B4','FAA5','FAB9','FA80','FA8D','FAC1','FA8E','FA79'
,'FA47','FA81','F93A','F9DF','FA35','F93F','FA98','FAD7','F96E','FABF','FAC6'
,'FAB8','FA9A','F960','F96D','FA62','FAA7','FA13','FAA9','FA16','F9B3','FAA0'
,'FAAE','FA1C','F945','F989','FA7F','F97B','FA75','F999','FA7B','F94B','FA8A'

#Enclosed_Ideographic_Supplement
,'1F263','1F262','1F264','1F260','1F265','1F243','1F261','1F226','1F22E','1F22C','1F223','1F210'

#soyombo
,'11A84','11A85','11A86','11A87','11A88','11A89'

#Unified Ideograph
,'6950'

#carian
,'10268'
#CJK Radical
,'2E85','2EC8','31CA','303C'

#devanagari
,'A8FA','A8F8','A8FE'

#arabic
,'0691','FC7B'

#Alchemical
,'1F74C'


#gujarati
,'0AF9'

#gurmukhi
,'0A2E','0A2D','0A09','0A76'

#halfwidth
,'FF17','FF11','FF3F','FF1B'

#hebrew
,'05EF'

#hangul



#kannada
,'0C84','0C80'

#Lao
,'0E86','0E89','0E98','0E91','0E92','0E93','0E90','0EAC','0EA0','0EA8','0E8E'
,'0EA9','0E8F','0E8C'

#extended latin d
,'A7C4','A7C6','A7A8','A7BD','A7B8','A7B9','A7BC','A7BA' ,'A7C3','A7BF','A7BE'
,'A7AF','A7C2','A7C5','A7BB'

#extended_latin_e
,'AB66','AB67'

#limbu
,'191C','191D','191E'

#karoshthi
,'10A34','10A35','10A48'

#Malayalam
,'OD78','0D5B','0D5C','0D4F','0D76','0D5D','0D54','0D5E','0D78','0D5F','0D5A','0D58','0D77'
,'0D4E' #special combining form
,'0D56','0D55','0D59'

#Miscellaneous_Symbols
,'2610'

#Miscellaneous_Symbols_And_Arrows
,'2BC9','2B45','2B0E','2BE2','2BD4','2BD5','2BD6','2BFA','2B3E','2BFD','2BD2','2B4C'
,'2BDD','2BF9','2B44','2BD8','2B42','2BDA','2BE6','2B40','2BFF','2BE6','2BF6','2BE5'
,'2BF0','2BEA','2BF8','2BE0','2BDB','2B47','2B31','2BE1','2BF7','2B49','2BF4','2BBC'
,'2BF1','2BDE','2B35','2B3D','2B3C','2BFB','2B46','2BF5','2BE3','2B39','2BDF','2BDC'
,'2BF3','2BE4','2BD9','2BBA','2BBB','2BEB','2BD3','2BD7','2BE9','2BF2','2B4A','2BE8'
,'2BFC','2BE7'

#Miscellaneous_Symbols_And_Pictographs
,'1F56D','1F599','1F5EC'

#Miscellaneous_Technical
,'23B8','23BB','23BC','23C5','2333','23B9','23BF','232D'
,'23BA','23B7','23FF','23BD','2392'

#Miscellaneous_Mathematical_Symbols_B
,'29A3'

#Mongolian
,'1878','1166A','1166B','11660','11661','11662','11663','11664','11665','11167','11669','11668','1166C'

#nko
,'07FE','07FF'

#Old_Italic
,'1032D','1032E','1032F'

#Old_Turkic
,'10C3F'

#Old Permic
,'10357'

#sharada
,'111C2','111C3'

#suppliemental_mathematical_operators
,'2AFE'

#supplemental punctualtion
,'2E45','2E46','2E47','2E48','2E4F','2E43','2E4C','2E4D','2E4E','2E49','2E4A','2E4B'

#Supplemental_Symbols_And_Pictographs no glyhph
,'1F9C4','1F904','1F978','1F906','1F9BB','1F9A7','1F905','1F9BD'
,'1F90F','1F901','1F90A','1F900','1F9CE','1F9C9','1F9C6','1F907'
,'1F9CA','1F9AE','1F9C8','1F909','1F90B','1F903','1F9C5','1F9AA'
,'1F9BE','1F90E','1F902','1F9CF','1F93F','1F97B','1F9A5','1F90D'
,'1F9C3','1F971','1F9AF','1F9A8','1F9A6','1F9C7','1F9A9','1F908'
,'1F9BC','1F9BA','1F9CD','1F9BF'
,'1F3FB','1F3FC','1F3FD','1F3FE','1F3FF' #skin
,'1F9B0','1F9B1','1F9B2','1F9B3','1F9B3' #hair

#Supplemental_Symbols_And_Pictographs without a non emoji backup
,'1F933','1F97E','1F9EF','1F932','1F9C2','1F6F7','1F3C5','1F9D6','1F98A','1F975','1F9D9','1F91B','1F9DF'
,'1F91D','1F9D1','1F987','1F925','1F641','1F98C','1F96D','1F91F'

#Miscellaneous_Symbols_And_Pictographs without text backup
,'1F37E','1F54D','1F3F8','1F54B','1F4FF','1F3FA','1F3D2','1F54C','1F4F8','1F42A','1F54E','1F3D1','1F3D2'
,'1F595','1F57A','1F3CF','1F596','1F37F','1F32F','1F3F9','1F32E','1F3D3'

#Emoticons (without text emoji backup)
,'1F642','1F643','1F641','1F644'

#Transport_And_Map_Symbols with no text emoji backup
,'1F6F6','1F6F7','1F6F5','1F6D2','1F6EB','1F6D0','1F6D1','1F6CC','1F6F8','1F6F4','1F6EB','1F6F9','1F6EC'


#Telegu
,'0C5A','0C69','0C34','0C77'

#Transport_And_Map_Symbols
,'1F6D3','1F6D4','1F6D5','1F6FA'

#Vedic_Extensions
,'1CFA'

#GeometricShapes
,'1F7E7','1F7E1','1F7E2','1F7EA','1F7D6','1F7D7','1F7D8','1F7E4','1F7E5','1F7E6','1F6D1','1F7DF'
,'1F7D5','1F7E8','1F78E','1F7E9','1F7E4','1F7E3','1F7E0','1F7EB'

#Counting_Rod_Numerals
,'1D377','1D375','1D373','1D378','1D376','1D372','1D374'


)

