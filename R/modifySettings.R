library(yaml)
Settings <- list(HEISPath       ="D:/HEIS/",
                 HEISRARPath    ="D:/HEIS/RARs/",
                 HEISRAWPath    ="D:/HEIS/DataRAW/",
                 HEISSummaryPath="D:/HEIS/Summary/",
                 HEISDataPath   ="D:/HEIS/DataProcessed/",
                 startyear=63,
                 endyear=92,
                 OS="windows",
                 RawDataWebAddress="http://www.amar.org.ir/Portals/0/amarmozuii/hazinedaramad/"
)
write(as.yaml(Settings),file = "Settings.yaml")