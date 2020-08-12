# /usr/bin/Rscript

########################
### Script Arguments ###
########################
# [1] = Assay Name in Project Directory i.e. 20200626_toxin08B
# [2] = "high" or "MDHD"

args <- commandArgs(trailingOnly = TRUE)
require(tidyverse)
basedir <- c("/projects/b1059/software/CellProfiler/")
setwd(paste(basedir, 
            "projects/", 
            as.character(args[1]), 
            "/output_data/", 
            paste(as.character(args[1]), "summary_data", sep = "_"),
            "/NonOverlappingWorms_Data", sep = ""))
metadata <- read_csv(paste(basedir,"metadata/",as.character(args[1]),"_metadata.csv", sep = ""))

#################
### High Dose ###
#################

if(args[2] == "high"){
  files <- list.files(pattern = "NonOverlappingWorms_high.csv")
  high.data <- list()
  for(i in 1:length(files)){
    data <- read_csv(files[[i]]) %>%
      dplyr::mutate(model = "high")
    high.data[[i]] <- data
  }
  high.data.df <- do.call(rbind, high.data)
  high.dose.model.outputs <- dplyr::left_join(high.data.df, metadata %>%
                                                dplyr::mutate(Metadata_Plate = as.integer(Metadata_Plate)))
} else if(args[2] == "MDHD"){
  files <- list.files(pattern = "NonOverlappingWorms_MDHD.csv")
  high.data <- list()
  for(i in 1:length(files)){
    data <- read_csv(files[[i]]) %>%
      dplyr::mutate(model = "MDHD")
    high.data[[i]] <- data
  }
  high.data.df <- do.call(rbind, high.data)
  high.dose.model.outputs <- dplyr::left_join(high.data.df, metadata %>%
                                                dplyr::mutate(Metadata_Plate = as.integer(Metadata_Plate)))
} else {"Error: Need to specify whether high dose model or MDHD model is to be concatenated"}

#################
### Full Dose ###
#################
files <- list.files(pattern = "NonOverlappingWorms_full.csv")
full.data <- list()
for(i in 1:length(files)){
  data <- read_csv(files[[i]]) %>%
    dplyr::mutate(model = "full")
  full.data[[i]] <- data
}
full.data.df <- do.call(rbind, full.data)
full.dose.model.outputs <- dplyr::left_join(full.data.df, metadata %>%
                                              dplyr::mutate(Metadata_Plate = as.integer(Metadata_Plate)))

###############
### Control ###
###############
files <- list.files(pattern = "NonOverlappingWorms_control.csv")
control.data <- list()
for(i in 1:length(files)){
  data <- read_csv(files[[i]]) %>%
    dplyr::mutate(model = "control")
  control.data[[i]] <- data
}
control.data.df <- do.call(rbind, control.data)
control.model.outputs <- dplyr::left_join(control.data.df, metadata %>%
                                            dplyr::mutate(Metadata_Plate = as.integer(Metadata_Plate)))

setwd(paste(basedir, "projects/", as.character(args[1]), "/output_data/", paste(as.character(args[1]), "summary_data", sep = "_"), sep = ""))
today <- format(Sys.time(), '%Y%m%d')
save.image(paste("CellProfiler-Analysis_",args[1],"_",args[2],"_",today,".RData",sep = ""))

