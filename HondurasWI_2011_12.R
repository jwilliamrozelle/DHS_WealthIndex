#Check for packages and install if necessary
pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
}

pkgTest("xlsx")
pkgTest("gtools")
pkgTest("plyr")
pkgTest("dplyr")

library(xlsx)
library(gtools)
library(plyr)
library(dplyr)

MyData <- read.xlsx(file.choose(), sheetIndex = 1)
MyDataWV <- MyData

#transform into wealth index values
#Macro
trans <- defmacro(df, variable, ifhas, ifnot,
                  expr={
                    df$variable <- ifelse(df$variable == 1, ifhas, ifelse(df$variable == 0, ifnot, 0))
                  })

#Remove artifacts from the XLS form (CAN BE IGNORED IF ALREADY DONE)
MyDataWV <- plyr::rename(MyDataWV, replace = c("table_list_own.QH141A" = "QH141A"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("table_list_own.QH141B" = "QH141B"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("table_list_own.QH141C" = "QH141C"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("table_list_own.QH141D" = "QH141D"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("table_list_own.QH141E" = "QH141E"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("table_list_own.QH141F" = "QH141F"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131A" = "QH131A"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131B" = "QH131B"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131C" = "QH131C"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131D" = "QH131D"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131E" = "QH131E"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131F" = "QH131F"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131G" = "QH131G"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131H" = "QH131H"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131I" = "QH131I"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131J" = "QH131J"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131K" = "QH131K"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("have.QH131L" = "QH131L"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("animals.QH145A" = "QH145A"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("animals.QH145B" = "QH145B"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("animals.QH145C" = "QH145C"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("animals.QH145D" = "QH145D"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("animals.QH145E" = "QH145E"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("animals.QH145F" = "QH145F"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("animals.QH145G" = "QH145G"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("windows.QH139A" = "QH139A"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("windows.QH139B" = "QH139B"))
MyDataWV <- plyr::rename(MyDataWV, replace = c("windows.QH139C" = "QH139C"))

#This version applies the total persons in HH to usual residents and the number who slept in HH last night
MyDataWV$HV012 <- MyDataWV$HV009
MyDataWV$HV013 <- MyDataWV$HV009

#Construct Variables
MyDataWV$hhusual <- MyDataWV$HV012
MyDataWV$hhslept <- MyDataWV$HV013

#Members per sleeping room
MyDataWV$hhusual <- ifelse(MyDataWV$hhusual == 0, MyDataWV$hhslept, MyDataWV$HV012)
MyDataWV$memsleep <- ifelse(MyDataWV$QH140>0, trunc(MyDataWV$hhusual/MyDataWV$QH140), ifelse(MyDataWV$QH140 == 0, MyDataWV$hhusual, NA))
MyDataWV$memsleep <- ifelse(MyDataWV$memsleep>=98, 98, MyDataWV$memsleep)

#Drinking water supply
MyDataWV$h2oires <- ifelse(MyDataWV$QH121 == 11, 1, 0)
MyDataWV$h2oyrd <- ifelse(MyDataWV$QH121 == 12, 1, 0)
MyDataWV$h2opires <- ifelse(MyDataWV$QH121 == 11, 1, 0)
MyDataWV$h2opyrd <- ifelse(MyDataWV$QH121 == 12, 1, 0)
MyDataWV$h2opub <- ifelse(MyDataWV$QH121 == 31, 1, 0)
MyDataWV$h2opwell <- ifelse(MyDataWV$QH121 == 21, 1, 0)
MyDataWV$h2obwell <- ifelse(MyDataWV$QH121 == 22, 1, 0)
MyDataWV$h2opspg <- ifelse(MyDataWV$QH121 == 41, 1, 0)
MyDataWV$h2orain <- ifelse(MyDataWV$QH121 == 51, 1, 0)
MyDataWV$h2otruck <- ifelse(MyDataWV$QH121 == 61, 1, 0)
MyDataWV$h2osurf <- ifelse(MyDataWV$QH121 == 71, 1, 0)
MyDataWV$h2obot <- ifelse(MyDataWV$QH121 == 81, 1, 0)
MyDataWV$h2ooth <- ifelse(MyDataWV$QH121 == 96, 1, 0)

#Toilet facility
MyDataWV$flushs <- ifelse(MyDataWV$QH128 == 11, 1, 0)
MyDataWV$flusht <- ifelse(MyDataWV$QH128 == 12, 1, 0)
MyDataWV$flushe <- ifelse(MyDataWV$QH128 == 13, 1, 0)
MyDataWV$latvip <- ifelse(MyDataWV$QH128 == 21, 1, 0)
MyDataWV$latcomp <- ifelse(MyDataWV$QH128 == 22, 1, 0)
MyDataWV$latpit <- ifelse(MyDataWV$QH128 == 23, 1, 0)
MyDataWV$lathang <- ifelse(MyDataWV$QH128 == 24, 1, 0)
MyDataWV$flushhang <- ifelse(MyDataWV$QH128 == 31, 1, 0)
MyDataWV$latbush <- ifelse(MyDataWV$QH128 == 61, 1, 0)
MyDataWV$latoth <- ifelse(MyDataWV$QH128 == 96, 1, 0)

#Share latrine
MyDataWV$latshare <- ifelse(MyDataWV$QH129 == 2, 1, 0)

#Shared toilet variables
MyDataWV$sflushs <- ifelse(MyDataWV$latshare ==1, ifelse(MyDataWV$QH128 == 11, 1, 0), 0)
MyDataWV$sflusht <- ifelse(MyDataWV$latshare ==1, ifelse(MyDataWV$QH128 == 12, 1, 0), 0)
MyDataWV$sflushe <- ifelse(MyDataWV$latshare ==1, ifelse(MyDataWV$QH128 == 13, 1, 0), 0)
MyDataWV$slatvip <- ifelse(MyDataWV$latshare ==1, ifelse(MyDataWV$QH128 == 21, 1, 0), 0)
MyDataWV$slatpit <- ifelse(MyDataWV$latshare ==1, ifelse(MyDataWV$QH128 == 23, 1, 0), 0)
MyDataWV$slatcomp <- ifelse(MyDataWV$latshare ==1, ifelse(MyDataWV$QH128 == 22, 1, 0), 0)
MyDataWV$slathang <- ifelse(MyDataWV$latshare ==1, ifelse(MyDataWV$QH128 == 24, 1, 0), 0)
MyDataWV$sflushhang <- ifelse(MyDataWV$latshare ==1, ifelse(MyDataWV$QH128 == 31, 1, 0), 0)
MyDataWV$slatoth <- ifelse(MyDataWV$latshare ==1, ifelse(MyDataWV$QH128 == 96, 1, 0), 0)

#Flooring
MyDataWV$dirtfloo <- ifelse(MyDataWV$QH136 == 11, 1, 0)
MyDataWV$woodfloo <- ifelse(MyDataWV$QH136 == 21, 1, 0)
MyDataWV$cemtfloo <- ifelse(MyDataWV$QH136 == 22, 1, 0)
MyDataWV$adobfloo <- ifelse(MyDataWV$QH136 == 23, 1, 0)
MyDataWV$embfloo <- ifelse(MyDataWV$QH136 == 24, 1, 0)
MyDataWV$prqfloo <- ifelse(MyDataWV$QH136 == 31, 1, 0)
MyDataWV$mosfloo <- ifelse(MyDataWV$QH136 == 32, 1, 0)
MyDataWV$granfloo <- ifelse(MyDataWV$QH136 == 33, 1, 0)
MyDataWV$tilefloo <- ifelse(MyDataWV$QH136 == 34, 1, 0)
MyDataWV$othfloo <- ifelse(MyDataWV$QH136 == 96, 1, 0)

#Roofing
MyDataWV$noroof <- ifelse(MyDataWV$QH138 == 11, 1, 0)
MyDataWV$natroof <- ifelse(MyDataWV$QH138 == 12, 1, 0)
MyDataWV$wproof <- ifelse(MyDataWV$QH138 == 21, 1, 0)
MyDataWV$cardroof <- ifelse(MyDataWV$QH138 == 22, 1, 0)
MyDataWV$tinroof <- ifelse(MyDataWV$QH138 == 31, 1, 0)
MyDataWV$cmtroof <- ifelse(MyDataWV$QH138 == 32, 1, 0)
MyDataWV$calroof <- ifelse(MyDataWV$QH138 == 33, 1, 0)
MyDataWV$cerroof <- ifelse(MyDataWV$QH138 == 34, 1, 0)
MyDataWV$ctroof <- ifelse(MyDataWV$QH138 == 35, 1, 0)
MyDataWV$othroof <- ifelse(MyDataWV$QH138 == 96, 1, 0)

#Walls
MyDataWV$nowall <- ifelse(MyDataWV$QH137 == 11, 1, 0)
MyDataWV$natwall <- ifelse(MyDataWV$QH137 == 12, 1, 0)
MyDataWV$bambwall <- ifelse(MyDataWV$QH137 == 21, 1, 0)
MyDataWV$stomwall <- ifelse(MyDataWV$QH137 == 22, 1, 0)
MyDataWV$adobwall <- ifelse(MyDataWV$QH137 == 23, 1, 0)
MyDataWV$rwoodwall <- ifelse(MyDataWV$QH137 == 24, 1, 0)
MyDataWV$bajawall <- ifelse(MyDataWV$QH137 == 25, 1, 0)
MyDataWV$cardwall <- ifelse(MyDataWV$QH137 == 26, 1, 0)
MyDataWV$cmtbwall <- ifelse(MyDataWV$QH137 == 31, 1, 0)
MyDataWV$woodwall <- ifelse(MyDataWV$QH137 == 32, 1, 0)
MyDataWV$stonwall <- ifelse(MyDataWV$QH137 == 33, 1, 0)
MyDataWV$brkwall <- ifelse(MyDataWV$QH137 == 34, 1, 0)
MyDataWV$prefwall <- ifelse(MyDataWV$QH137 == 35, 1, 0)
MyDataWV$othwall <- ifelse(MyDataWV$QH137 == 96, 1, 0)

#Cooking Fuel
MyDataWV$cookelec <- ifelse(MyDataWV$QH132 == 1, 1, 0)
MyDataWV$cooklpg <- ifelse(MyDataWV$QH132 == 2, 1, 0)
MyDataWV$cookkero <- ifelse(MyDataWV$QH132 == 3, 1, 0)
MyDataWV$cookchar <- ifelse(MyDataWV$QH132 == 4, 1, 0)
MyDataWV$cookwood <- ifelse(MyDataWV$QH132 == 5, 1, 0)
MyDataWV$cooknone <- ifelse(MyDataWV$QH132 == 6, 1, 0)
MyDataWV$cookoth <- ifelse(MyDataWV$QH132 == 96, 1, 0)

#Reset missing values to "does not have", change 2 code to 0
MyDataWV$QH131A <- ifelse(is.na(MyDataWV$QH131A) | MyDataWV$QH131A != 1, 0, MyDataWV$QH131A)
MyDataWV$QH131B <- ifelse(is.na(MyDataWV$QH131B) | MyDataWV$QH131B != 1, 0, MyDataWV$QH131B)
MyDataWV$QH131C <- ifelse(is.na(MyDataWV$QH131C) | MyDataWV$QH131C != 1, 0, MyDataWV$QH131C)
MyDataWV$QH131D <- ifelse(is.na(MyDataWV$QH131D) | MyDataWV$QH131D != 1, 0, MyDataWV$QH131D)
MyDataWV$QH131E <- ifelse(is.na(MyDataWV$QH131E) | MyDataWV$QH131E != 1, 0, MyDataWV$QH131E)
MyDataWV$QH131F <- ifelse(is.na(MyDataWV$QH131F) | MyDataWV$QH131F != 1, 0, MyDataWV$QH131F)
MyDataWV$QH131G <- ifelse(is.na(MyDataWV$QH131G) | MyDataWV$QH131G != 1, 0, MyDataWV$QH131G)
MyDataWV$QH131H <- ifelse(is.na(MyDataWV$QH131H) | MyDataWV$QH131H != 1, 0, MyDataWV$QH131H)
MyDataWV$QH131I <- ifelse(is.na(MyDataWV$QH131I) | MyDataWV$QH131I != 1, 0, MyDataWV$QH131I)
MyDataWV$QH131J <- ifelse(is.na(MyDataWV$QH131J) | MyDataWV$QH131J != 1, 0, MyDataWV$QH131J)
MyDataWV$QH131K <- ifelse(is.na(MyDataWV$QH131K) | MyDataWV$QH131K != 1, 0, MyDataWV$QH131K)
MyDataWV$QH131L <- ifelse(is.na(MyDataWV$QH131L) | MyDataWV$QH131L != 1, 0, MyDataWV$QH131L)

MyDataWV$QH141A <- ifelse(is.na(MyDataWV$QH141A) | MyDataWV$QH141A != 1, 0, MyDataWV$QH141A)
MyDataWV$QH141B <- ifelse(is.na(MyDataWV$QH141B) | MyDataWV$QH141B != 1, 0, MyDataWV$QH141B)
MyDataWV$QH141C <- ifelse(is.na(MyDataWV$QH141C) | MyDataWV$QH141C != 1, 0, MyDataWV$QH141C)
MyDataWV$QH141D <- ifelse(is.na(MyDataWV$QH141D) | MyDataWV$QH141D != 1, 0, MyDataWV$QH141D)
MyDataWV$QH141E <- ifelse(is.na(MyDataWV$QH141E) | MyDataWV$QH141E != 1, 0, MyDataWV$QH141E)
MyDataWV$QH141F <- ifelse(is.na(MyDataWV$QH141F) | MyDataWV$QH141F != 1, 0, MyDataWV$QH141F)

MyDataWV$QH139 <- ifelse(is.na(MyDataWV$QH139) | MyDataWV$QH139 != 1, 0, MyDataWV$QH139)
MyDataWV$QH139A <- ifelse(is.na(MyDataWV$QH139A) | MyDataWV$QH139A != 1, 0, MyDataWV$QH139A)
MyDataWV$QH139B <- ifelse(is.na(MyDataWV$QH139B) | MyDataWV$QH139B != 1, 0, MyDataWV$QH139B)
MyDataWV$QH139C <- ifelse(is.na(MyDataWV$QH139C) | MyDataWV$QH139C != 1, 0, MyDataWV$QH139C)

#LAND
MyDataWV$landarea <- ifelse(MyDataWV$QH143U == 1, MyDataWV$QH143N*(6972.76/10000), ifelse(MyDataWV$QH143U == 2, MyDataWV$QH143N*(690.3/10000), 0))

#Animals
MyDataWV$QH144 <- ifelse(is.na(MyDataWV$QH144) | MyDataWV$QH144 != 1, 0, MyDataWV$QH144)
MyDataWV$QH145A <- ifelse(is.na(MyDataWV$QH145A) | MyDataWV$QH145A != 1, 0, MyDataWV$QH145A)
MyDataWV$QH145B <- ifelse(is.na(MyDataWV$QH145B) | MyDataWV$QH145B != 1, 0, MyDataWV$QH145B)
MyDataWV$QH145C <- ifelse(is.na(MyDataWV$QH145C) | MyDataWV$QH145C != 1, 0, MyDataWV$QH145C)
MyDataWV$QH145D <- ifelse(is.na(MyDataWV$QH145D) | MyDataWV$QH145D != 1, 0, MyDataWV$QH145D)
MyDataWV$QH145E <- ifelse(is.na(MyDataWV$QH145E) | MyDataWV$QH145E != 1, 0, MyDataWV$QH145E)
MyDataWV$QH145F <- ifelse(is.na(MyDataWV$QH145F) | MyDataWV$QH145F != 1, 0, MyDataWV$QH145F)
MyDataWV$QH145G <- ifelse(is.na(MyDataWV$QH145G) | MyDataWV$QH145G != 1, 0, MyDataWV$QH145G)

#Bank account
MyDataWV$QH146 <- ifelse(is.na(MyDataWV$QH146) | MyDataWV$QH146 != 1, 0, MyDataWV$QH146)

#Compute urban and rural variables (1/0) for filters later

MyDataWV$urban <- ifelse(MyDataWV$QHTYPE == 1, 1, 0)
MyDataWV$rural <- ifelse(MyDataWV$QHTYPE == 2, 1, 0)


#Variables (Rural)
trans(MyDataWV, QH131A, 0.00993662228496725, -0.105109237970489)
trans(MyDataWV, QH131B, 0.0113621524676306, -0.11093879423256)
trans(MyDataWV, QH131C, 0.00223038669510266, -0.107085008637992)
trans(MyDataWV, QH131D, 0.0954091419968593, -0.0585767177924229)
trans(MyDataWV, QH131E, 0.163472227681211, -0.0497000957226187)
trans(MyDataWV, QH131F, 0.301675859549663, -0.00648631677588452)
trans(MyDataWV, QH131G, 0.00811913503044838, -0.0248789883315837)
trans(MyDataWV, QH131H, 0.0939107480474971, -0.0823140212910265)
trans(MyDataWV, QH131I, 0.224967394381807, -0.00947211232753049)
trans(MyDataWV, QH131J, 0.0260792873159355, -0.0910036825311318)
trans(MyDataWV, QH131K, 0.137364831726806, -0.0646183193952612)
trans(MyDataWV, QH131L, 0.261959983081751, -0.0173198544398475)
trans(MyDataWV, QH139, 0.0109933623462269, -0.0995643773887392)
trans(MyDataWV, QH139A, 0.262133098099951, -0.0120045772343994)
trans(MyDataWV, QH139B, 0.220480736540336, -0.0292416906701286)
trans(MyDataWV, QH139C, -0.0228175606809578, 0.0791052608045885)
trans(MyDataWV, QH141A, 0.0430474759946703, -0.0186194258461235)
trans(MyDataWV, QH141B, 0.111911001364413, -0.0103422289165068)
trans(MyDataWV, QH141C, 0.0438930925729232, -0.000829532563005121)
trans(MyDataWV, QH141D, 0.178838859892518, -0.0227246615278804)
trans(MyDataWV, QH141E, 0.415440863073426, -0.000570337936868953)
trans(MyDataWV, QH141F, 0.389340539321642, -0.00100734939022417)
trans(MyDataWV, QH142, -0.0238255964534699, -0.0708248640358795)
trans(MyDataWV, QH144, -0.0271089060903862, 0.0719336500442011)
MyDataWV$QH145A <- ((MyDataWV$QH145A - 0.39258064516129)/3.10148945300663) * 0.0103941048837925
MyDataWV$QH145B <- ((MyDataWV$QH145B - 0.892258064516129)/4.57635049482176) * 0.0161253423672075
MyDataWV$QH145C <- ((MyDataWV$QH145C - 0.386290322580645)/1.11979704743353) * -0.00221569876382489
MyDataWV$QH145D <- ((MyDataWV$QH145D - 0.461854838709677)/1.86710582105154) * -0.0010087769484605
MyDataWV$QH145E <- ((MyDataWV$QH145E - 0.0229032258064516)/0.443382532716214) * 0.000384336823529891
MyDataWV$QH145F <- ((MyDataWV$QH145F - 0.0561290322580645)/1.15417427234865) * 0.00386973251517766
MyDataWV$QH145G <- ((MyDataWV$QH145G - 11.0315322580645)/13.2037049074528) * -0.0154618586723455
trans(MyDataWV, QH146, 0.134093492626749, -0.0309938096539983)
trans(MyDataWV, DOMESTIC, 0.22125133725097, -0.00141862313471525)
trans(MyDataWV, HOUSE, -0.00684094630800884, 0.00396238204391546)
MyDataWV$memsleep <- ((MyDataWV$memsleep - 2.98121457489879)/1.86640773773725) * -0.0517329950764196
trans(MyDataWV, h2oires, 0.219414882713799, -0.00149649643942507)
trans(MyDataWV, h2oyrd, 0.00122686739002963, -1.71554766289203E-05)
trans(MyDataWV, h2opires, 0.2194148827138, -0.00149649643942507)
trans(MyDataWV, h2opyrd, 0.00122686739002952, -1.71554766289188E-05)
trans(MyDataWV, h2opub, -0.0527256380443158, 0.000532582202467836)
trans(MyDataWV, h2obwell, -0.00911184852900667, 0.000314725954531016)
trans(MyDataWV, h2opwell, -0.0666745523088172, 0.00140552415934265)
trans(MyDataWV, h2opspg, -0.0956580126517762, 0.0171698535027016)
trans(MyDataWV, h2orain, -0.0464855421609508, 0.000557689928805988)
trans(MyDataWV, h2otruck, 0.185563207616566, -0.000224743489240895)
trans(MyDataWV, h2osurf, -0.0896576771655305, 0.00258120086090094)
trans(MyDataWV, h2obot, 0.214768135618097, -0.0306585422608453)
trans(MyDataWV, h2ooth, -0.0588024163251413, 0.00108177901255188)
trans(MyDataWV, flushs, 0.221478888281638, -0.00705886778828888)
trans(MyDataWV, flusht, 0.122052047477917, -0.0409820351167367)
trans(MyDataWV, flushe, 0.13083853515011, -0.000116169496057084)
trans(MyDataWV, latvip, -0.030515574777096, 0.0165892586893537)
trans(MyDataWV, latcomp, -0.0541264732999877, 0.000148819350816722)
trans(MyDataWV, latpit, -0.049302981867525, 0.00839942258337731)
trans(MyDataWV, lathang, 0.0157729428398021, -0.00012694263402491)
trans(MyDataWV, flushhang, 0.136594699323277, -0.00120014867612382)
trans(MyDataWV, latbush, -0.104752468309914, 0.0260826049216465)
trans(MyDataWV, latoth, 0.00654503038165224, -2.11198140743861E-06)
trans(MyDataWV, latshare, -0.0208538217517406, 0.00276793669546716)
trans(MyDataWV, sflushs, 0.179353087784214, -0.000333289247720523)
trans(MyDataWV, sflusht, 0.0693203658384243, -0.00185987069655925)
trans(MyDataWV, sflushhang, 0.0700086800231314, -4.51960490788453E-05)
trans(MyDataWV, sflushe, 0.0217543128466198, -1.75452156195014E-06)
trans(MyDataWV, slatvip, -0.049624878287643, 0.00281661572691071)
trans(MyDataWV, slatpit, -0.0596930074219491, 0.00191275970515609)
trans(MyDataWV, slatcomp, -0.127707387717584, 6.18238120304588E-05)
trans(MyDataWV, slathang, -0.0195539974686526, 5.85212251346879E-05)
trans(MyDataWV, slatoth, 0.0181242402225409, -4.3859579468922E-06)
trans(MyDataWV, dirtfloo, -0.100714224309192, 0.0517526761222548)
trans(MyDataWV, woodfloo, -0.0219935677025035, 0.00101303255994322)
trans(MyDataWV, cemtfloo, 0.0311719578828317, -0.0223273193140005)
trans(MyDataWV, adobfloo, -0.0191627828664439, 0.000203028669326627)
trans(MyDataWV, embfloo, -0.0888481817941231, 0.00300753391765999)
trans(MyDataWV, prqfloo, 0.284995667187529, -0.00136251068503883)
trans(MyDataWV, mosfloo, 0.120780308135852, -0.0123345990621361)
trans(MyDataWV, granfloo, 0.177539414741244, -0.00161819779061029)
trans(MyDataWV, tilefloo, 0.225486796210504, -0.011626184879239)
trans(MyDataWV, othfloo, 0.137921885727748, -5.56360975101849E-05)
trans(MyDataWV, noroof, -0.00248759257731761, 8.02708156604584E-07)
trans(MyDataWV, natroof, -0.129570485021258, 0.0021672990279056)
trans(MyDataWV, wproof, -0.0769410077330113, 5.58848413846422E-05)
trans(MyDataWV, cardroof, -0.134886641547063, 0.000163366945757444)
trans(MyDataWV, tinroof, 0.0215168385530058, -0.024949340140354)
trans(MyDataWV, cmtroof, 0.280654089494526, -0.000908265661794584)
trans(MyDataWV, calroof, 0.152750530310661, -0.00422830077273006)
trans(MyDataWV, cerroof, -0.0401821491374788, 0.0263588029598418)
trans(MyDataWV, ctroof, 0.0584369348003058, -0.000841369480109115)
trans(MyDataWV, othroof, 0.223832547009031, -0.000869815597185354)
trans(MyDataWV, nowall, -0.0830813862637729, 6.70065217064061E-06)
trans(MyDataWV, natwall, -0.0977835868318509, 0.000213380493369431)
trans(MyDataWV, bambwall, -0.0474578476256965, 6.89905715766868E-05)
trans(MyDataWV, stomwall, -4.94405025524536E-05, 6.38766182848238E-08)
trans(MyDataWV, adobwall, -0.0433146587106768, 0.052017568483571)
trans(MyDataWV, rwoodwall, -0.0402050284490405, 0.0042441827464037)
trans(MyDataWV, bajawall, -0.0964282477910609, 0.011235201930635)
trans(MyDataWV, cardwall, -0.118302215597013, 0.000306085939448934)
trans(MyDataWV, cmtbwall, 0.154237214795703, -0.0380166516565202)
trans(MyDataWV, woodwall, 0.171099103996133, -0.00141910136669422)
trans(MyDataWV, stonwall, 0.194066121717098, -0.000109615335432881)
trans(MyDataWV, brkwall, 0.165277109457272, -0.00570872045013437)
trans(MyDataWV, prefwall, 0.210096413901679, -0.000782291973407578)
trans(MyDataWV, othwall, -0.05555004625881, 0.00018428286241696)
trans(MyDataWV, cookelec, 0.222764362469125, -0.0110100192689547)
trans(MyDataWV, cooklpg, 0.240974945590966, -0.0223392353508721)
trans(MyDataWV, cookkero, 0.12751033909552, -0.000360926960642394)
trans(MyDataWV, cookchar, 0.00591551102506604, -1.14715792341294E-05)
trans(MyDataWV, cookwood, -0.0374936516221043, 0.204779032126772)
trans(MyDataWV, cooknone, 0.0216708661134342, -0.000391427795152342)
trans(MyDataWV, cookoth, -0.00322463811976166, 2.60072434854557E-07)
MyDataWV$landarea <- ((MyDataWV$landarea - 2.34019535650325)/9.10132613052762) * 0.0055605909173712

#Calculate Rural Index
MyDataWV <- mutate(MyDataWV, Rural = QH131A+QH131B+QH131C+QH131D+QH131E+QH131F+QH131G+QH131H+QH131I+QH131J+QH131K+QH131L+QH139+QH139A+QH139B+QH139C+QH141A+QH141B+QH141C+QH141D+QH141E+QH141F+QH142+QH144+QH145A+QH145B+QH145C+QH145D+QH145E+QH145F+QH145G+QH146+DOMESTIC+HOUSE+memsleep+h2oires+h2oyrd+h2opires+h2opyrd+h2opub+h2obwell+h2opwell+h2opspg+h2orain+h2otruck+h2osurf+h2obot+h2ooth+flushs+flusht+flushe+latvip+latcomp+latpit+lathang+flushhang+latbush+latoth+latshare+sflushs+sflusht+sflushhang+sflushe+slatvip+slatpit+slatcomp+slathang+slatoth+dirtfloo+woodfloo+cemtfloo+adobfloo+embfloo+prqfloo+mosfloo+granfloo+tilefloo+othfloo+noroof+natroof+wproof+cardroof+tinroof+cmtroof+calroof+cerroof+ctroof+othroof+nowall+natwall+bambwall+stomwall+adobwall+rwoodwall+bajawall+cardwall+cmtbwall+woodwall+stonwall+brkwall+prefwall+othwall+cookelec+cooklpg+cookkero+cookchar+cookwood+cooknone+cookoth+landarea)
summary(MyDataWV$Rural)


#Calculate Combined Index
MyDataWV$Combined <- (-0.533 + 0.744 * MyDataWV$Rural)
summary(MyDataWV$Combined)
hist(MyDataWV$Combined, main = "Histogram of Wealth Index", xlab = "Combined score")

#Quintiles
MyDataWV$Quintile <- ifelse(MyDataWV$Combined <= -.9165920 & !is.na(MyDataWV$Combined), 5, ifelse(MyDataWV$Combined > -.9165920 & MyDataWV$Combined <= -.3085255, 4, ifelse(MyDataWV$Combined > -.3085255 & MyDataWV$Combined <= .4736003, 3, ifelse(MyDataWV$Combined > .4736003 & MyDataWV$Combined <= 1.1760208, 2, ifelse(MyDataWV$Combined > 1.1760208 & !is.na(MyDataWV$Combined), 1, NA)))))

table(MyDataWV$Quintile, useNA="always")

#Output Dataset
WealthIndex <- select(MyDataWV, HH_ID, Rural, Combined, Quintile)

#Save to xlsx
write.xlsx(WealthIndex,file=file.choose())
