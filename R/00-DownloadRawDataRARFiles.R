library(yaml)
Settings <- yaml.load_file("Settings.yaml")
file_list_rar <- list.files(Settings$HIESRARPath)
years <- Settings$startyear:Settings$endyear
needed_rars <- paste0(years,".rar")

files_to_download <- setdiff(needed_rars,file_list_rar)

if(length(files_to_download)>0){
  urls <- paste0(Settings$RawDataWebAddress,files_to_download)
  for(i in 1:length(files_to_download)){
    cat(paste0("Downloading file ",i," / ",length(files_to_download)," : ",files_to_download[i]),"\n")
    try(download.file(urls[i], paste0(Settings$HIESRARPath, files_to_download[i])))
  }
}else{
    cat("All files in the range specified in Setting.yaml file are present, no need to download.")
}