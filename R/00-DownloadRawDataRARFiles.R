# 00-DownloaRawDataRARFiles.R
# downloads the RAR files that are not present in the folder 
# specified in Settings file
#
# Copyright © 2015: Majid Einian
# Licence: GPL-3

rm(list=ls())

library(yaml)
Settings <- yaml.load_file("Settings.yaml")


file_list_rar <- list.files(Settings$HEISRARPath)
years <- Settings$startyear:Settings$endyear
needed_rars <- paste0(years,".rar")

files_to_download <- setdiff(needed_rars,file_list_rar)

if(length(files_to_download)>0){
  urls <- paste0(Settings$RawDataWebAddress,files_to_download)
  for(i in 1:length(files_to_download)){
    cat(paste0("Downloading file ",i," / ",length(files_to_download)," : ",files_to_download[i]),"\n")
    try(download.file(urls[i], paste0(Settings$HEISRARPath, files_to_download[i]),mode="wb"))
  }
}else{
    cat("All files in the range specified in Setting.yaml file are present, no need to download.")
}