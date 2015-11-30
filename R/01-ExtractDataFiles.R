# 00-UNRARDataFiles.R
# downloads the RAR files that are not present in the folder 
# specified in Settings file
#
# Copyright © 2015: Majid Einian
# Licence: GPL-3

rm(list=ls())

library(yaml)
Settings <- yaml.load_file("Settings.yaml")

dir.create(Settings$HEISRawPath,showWarnings = FALSE)

compressed_file_names_df <- read.csv(Settings$HEISCompressedPath,stringsAsFactors = FALSE)


existing_file_list <- tools::file_path_sans_ext(list.files(Settings$HEISRawPath))
years <- Settings$startyear:Settings$endyear

compressed_files_list <- compressed_file_names_df[compressed_file_names_df$Year %in% years,]$CompressedFileName

years_to_extract <- setdiff(compressed_files_list,existing_file_list)


if(Settings$OS=="windows"){
#  cmdline <- paste0(normalizePath("../exe/unrar/UnRAR.exe")," e -y ") # Use unrar binary
   cmdline <- paste0(normalizePath("../exe/7z/7z.exe")," e -y ")      # Use 7-zip binary
}

cwd <- getwd()
dir.create("temp")
setwd("temp")
for(filename in years_to_extract)
{
  file.copy(from = filename,to = ".")
  system(paste0(cmdline,filename))
  l <- dir(pattern=glob2rx("*.mdb"),ignore.case = TRUE)
  if(length(l)>0){
    file.rename(from = l,to = paste0(year,".mdb"))
    file.copy(from = paste0(year,".mdb"),to = paste0(Settings$HEISRAWPath,year,".mdb"))
  }
  l <- dir(pattern=glob2rx("*.accdb"),ignore.case = TRUE)
  if(length(l)>0){
    file.rename(from = l,to = paste0(year,".accdb"))
    file.copy(from = paste0(year,".accdb"),to = paste0(Settings$HEISRAWPath,year,".accdb"))
  }
  unlink("*.*")
}
setwd(cwd)
unlink("temp",recursive = TRUE,force = TRUE)


existing_file_list <- tools::file_path_sans_ext(list.files(Settings$HEISRAWPath))
years <- Settings$startyear:Settings$endyear
years_had_error <- setdiff(years,existing_file_list)
if (length(years_had_error)>0 ){
  cat("\n------------------\nFollowing years had errors; you have to provide the *.mdb files manually for these years:\n")
  cat(years_had_error)
}
