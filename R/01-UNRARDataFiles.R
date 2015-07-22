# 00-UNRARDataFiles.R
# downloads the RAR files that are not present in the folder 
# specified in Settings file
#
# Copyright © 2015: Majid Einian
# Licence: GPL-3

rm(list=ls())

library(yaml)
Settings <- yaml.load_file("Settings.yaml")

dir.create(Settings$HIESRAWPath,showWarnings = FALSE)


existing_file_list <- tools::file_path_sans_ext(list.files(Settings$HIESRAWPath))
years <- Settings$startyear:Settings$endyear
years_to_extract <- setdiff(years,existing_file_list)


if(Settings$OS=="windows"){
  cmdline <- paste0(normalizePath("../exe/7z/7z.exe")," e -y ")
}

cwd <- getwd()
dir.create("temp")
setwd("temp")
for(year in years_to_extract)
{
  file.copy(from = paste0(Settings$HIESRARPath,year,".rar"),to = ".")
  system(paste0("../../exe/7z/7z.exe e -y ",year,".rar"))
  l <- dir(pattern=glob2rx("*.mdb"))
  if(length(l)>0){
    file.rename(from = l,to = paste0(year,".mdb"))
    file.copy(from = paste0(year,".mdb"),to = paste0(Settings$HIESRAWPath,year,".mdb"))
  }
  l <- dir(pattern=glob2rx("*.accdb"))
  if(length(l)>0){
    file.rename(from = l,to = paste0(year,".accdb"))
    file.copy(from = paste0(year,".accdb"),to = paste0(Settings$HIESRAWPath,year,".accdb"))
  }
  unlink("*.*")
}
setwd(cwd)
unlink("temp",recursive = TRUE,force = TRUE)


existing_file_list <- tools::file_path_sans_ext(list.files(Settings$HIESRAWPath))
years <- Settings$startyear:Settings$endyear
years_had_error <- setdiff(years,existing_file_list)
cat("\n------------------\nFollowing years had errors; you have to provide the *.mdb files manually for these years:\n")
cat(years_had_error)
