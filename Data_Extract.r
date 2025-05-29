library(aquarius2018)
# Data from Rangitaiki at SH5 FC231176

Rangitaiki_Disc <- getdata("Discharge.Primary@FC231176",start="2023-01-20",end="2023-03-01")
write.csv(Rangitaiki_Disc,"Rangitaiki_Discharge.csv",row.names = F)

Rangitaiki_NO3 <-getdata("NO3-N.Primary@FC231176",start="2023-01-20",end="2023-03-01")
write.csv(Rangitaiki_NO3,"Rangitaiki_Nitrate.csv",row.names = F)

WQ_Data <- AQMultiExtractFlat(sitelist = "FC231176",param = "NNN",start="2023-01-20",end="2023-03-01")
write.csv(WQ_Data,"Rangitaiki_NNN.csv",row.names = F)

#Rainfall data
TeWhaiti_Minginui_Rainfall <- getdata("Precip Total.Primary@IF912193",start="2023-01-20",end="2023-03-01")
write.csv(TeWhaiti_Minginui_Rainfall,"TeWhaiti_Minginui_Rainfall.csv",row.names = F)

