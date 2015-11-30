library(yaml)
HEISPath           = "D:/HEIS/"
HEISCompressedPath = paste0(HEISPath,"DataCompressed/")
HEISRawPath        = paste0(HEISPath,"DataRAW/")
HEISDataPath       = paste0(HEISPath,"DataProcessed/")


Settings <- list(HEISPath          = HEISPath,
                 HEISCompressedPath=HEISCompressedPath,
                 HEISRawPath       =HEISRawPath,
                 HEISDataPath      =HEISDataPath,
                 startyear=63,
                 endyear=93,
                 OS="windows",
                 RawDataWebAddress="http://www.amar.org.ir/Portals/0/amarmozuii/hazinedaramad/",
                 CompressedFileNamesFile="../Data/CompressedFileNames.csv",
                 weightsFile="../Data/AllWeights.rda"
)
write(as.yaml(Settings),file = "Settings.yaml")