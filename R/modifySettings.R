library(yaml)
Settings <- list(HIESPath       ="D:/MajidFiles/HEIS/",
                 HIESRARPath    ="D:/MajidFiles/HEIS/RARs/",
                 HIESRAWPath    ="D:/MajidFiles/HEIS/DataRAW/",
                 HIESSummaryPath="D:/MajidFiles/HEIS/Summary/",
                 startyear=63,
                 endyear=92,
                 OS="windows",
                 RawDataWebAddress="http://www.amar.org.ir/Portals/0/amarmozuii/hazinedaramad/"
)
write(as.yaml(Settings),file = "Settings.yaml")