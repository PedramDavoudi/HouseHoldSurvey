library(yaml)
Settings <- list(HIESPath       ="D:/MajidFiles/HEIS/",
                 HIESRARPath    ="D:/MajidFiles/HEIS/RARs/",
                 HIESRAWPath    ="D:/MajidFiles/HEIS/RAW/",
                 HIESSummaryPath="D:/MajidFiles/HEIS/Summary/",
                 startyear=70,
                 endyear=92,
                 os="windows",
                 RawDataWebAddress="http://www.amar.org.ir/Portals/0/amarmozuii/hazinedaramad/"
)
write(as.yaml(Settings),file = "Settings.yaml")