


exclude_blocks <- c(
	'Ahom','Ancient_Greek_Musical_Notation'
,'Bassa_Vah','Bhaiksuki','Byzantine_Musical_Symbols'
,'Caucasian_Albanian','Chess_Symbols','CJK_Compatibility_Ideographs','Counting_Rod_Numerals'
,'Dogra','Duployan'
,'Elbasan','Elymaic'
,'Georgian_Extended','Grantha','Gunjala_Gondi'
,'Hatran','Hanifi_Rohingya'
,'Ideographic_Symbols_And_Punctuation','Indic_Siyaq_Numbers'
,'Kana_Extended_A','Kana_Supplement','Kharoshthi','Khojki','Khudawadi'
,'Linear_A'
,'Mahajani','Makasar','Manichaean','Marchen','Masaram_Gondi','Mayan_Numerals','Medefaidrin'
,'Mende_Kikakui','Meroitic_Cursive','Meroitic_Hieroglyphs','Miao','Modi'
,'Mongolian_Supplement','Mro','Multani','Musical_Symbols'
,'Nabataean','Nandinagari','Newa','Nyiakeng_Puachue_Hmong','Nushu'
,'Old_Hungarian','Old_North_Arabian','Old_Permic','Old_Sogdian'
,'Ottoman_Siyaq_Numbers'
,'Pahawh_Hmong','Palmyrene','Pau_Cin_Hau','Psalter_Pahlavi'
,'Rejang'
,'Sharada','Siddham','Small_Kana_Extension','Sogdian','Sora_Sompeng','Soyombo'
,'Sutton_SignWriting','Syriac_Supplement','Symbols_And_Pictographs_Extended_A'
,'Takri','Tamil_Supplement','Tangut','Tangut_Components','Tirhuta'
,'Wancho','Warang_Citi','Zanabazar_Square'
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
,'FAD3','FA89','FA77','FAA4','FABE','FA91','332C'

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

#georgian


#gujarati
,'0AF9'

#gurmukhi
,'0A2E','0A2D','0A09','0A76'

#halfwidth
,'FF17','FF11','FF3F','FF1B'

#hebrew
,'05EF'

#hangul
,'',''
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
,'1878'

#nko
,'07FE','07FF'

#Old_Italic
,'1032D','1032E','1032F'

#Old_Turkic
,'10C3F'

#suppliemental_mathematical_operators
,'2AFE'

#supplemental punctualtion
,'2E45','2E46','2E47','2E48','2E4F','2E43','2E4C','2E4D','2E4E','2E49','2E4A','2E4B'

#Supplemental_Symbols_And_Pictographs
,'1F9C4','1F904','1F978','1F906','1F9BB','1F9A7','1F905','1F9BD'
,'1F90F','1F901','1F90A','1F900','1F9CE','1F9C9','1F9C6','1F907'
,'1F9CA','1F9AE','1F9C8','1F909','1F90B','1F903','1F9C5','1F9AA'
,'1F9BE','1F90E','1F902','1F9CF','1F93F','1F97B','1F9A5','1F90D'
,'1F9C3','1F971','1F9AF','1F9A8','1F9A6','1F9C7','1F9A9','1F908'
,'1F9BC','1F9BA','1F9CD','1F9BF'
,'1F3FB','1F3FC','1F3FD','1F3FE','1F3FF' #skin
,'1F9B0','1F9B1','1F9B2','1F9B3','1F9B3' #hair

#Telegu
,'0C5A','0C69','0C34','0C77'

#Transport_And_Map_Symbols
,'1F6D3','1F6D4','1F6D5','1F6FA'

#Vedic_Extensions
,'1CFA'
)

