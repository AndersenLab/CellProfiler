# /usr/bin/Rscript

################################
### Script Arguments & Setup ###
################################
# [1] = specific output_data folder for a project e.g. 20200626_toxin08B_data_1600974923
# [2] = Metadata Filename
# [3] = Output Info - Optional - Anything specific to be added to the aggregated Rdata file name. e.g. threshold_strategy_global
args <- commandArgs(trailingOnly = TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)<2) {
  stop("At least two arguments must be supplied:
  1) path to specific summary_data folder e.g. 20200626_toxin08B/output_data/20200626_toxin08B_data_1600974923
  2) Metadata Filename", call.=FALSE)
} else if (length(args)==2) {
  # default output info is blank
  arg_count = 2
  message("Optional output info argument not supplied: It will be skipped")
} else if (length(args)==3) {
  arg_count = 3
  message(paste0("Optional output info argument (",as.character(args[3]),") will be appended to .Rdata file name"))
}

require(tidyverse)
basedir <- getwd()
chunks <- stringr::str_split(as.character(args[1]), pattern = "_data_")
project <- chunks[[1]][1]
setwd(paste0(basedir, "/projects/", project, "/output_data/", as.character(args[1]), "/NonOverlappingWorms_Data"))
  
#####################
### Read Metadata ###
#####################
message(paste("Reading metadata file from:", basedir, "/metadata/", as.character(args[2]), sep = ""))
metadata <- readr::read_csv(paste(basedir, "/metadata/", as.character(args[2]), sep = "")) %>%
  dplyr::mutate(Metadata_Plate = as.integer(stringr::str_replace(Metadata_Plate, pattern = "p", replacement = ""))) %>%
  dplyr::mutate(Metadata_Date = as.integer(Metadata_Date))

################################
### Aggregate CP Output Data ###
################################
message("Aggregating CellProfiler data into .Rdata file. This may take a few minutes.")
files <- list.files(pattern = "NonOverlappingWorms")
file.df <- data.frame(do.call(rbind, as.list(files))) %>%
  `colnames<-`(c("filename")) %>%
  tidyr::separate(col = filename, into = c("name"), sep = "[.]", remove = F, extra = "drop") %>% # remove extenstion get name
  tidyr::separate(col = name, into = c(NA,NA,NA,"model"), sep = "_", extra = "merge") %>% #parse name for full model name
  dplyr::group_by(model) %>%
  tidyr::nest()
for(j in 1:length(file.df$data)){
  message(paste("Generating", file.df$model[[j]], "Output Data", sep = " "))
  x <- file.df$data[[j]]
  data.to.read <- as.character(x$filename)
  model.specific.data <- list()
  for(i in 1:length(data.to.read)){
    file_metadata <- as_tibble(data.to.read[[i]]) %>% #should be i not 1
      tidyr::separate(col = value,
                      into = c("Metadata_Date","Metadata_Experiment","Metadata_Plate","chunk"), 
                      sep = "-") %>%
      tidyr::separate(col = chunk,
                      into = c("Metadata_Magnification", "Metadata_Well"), extra = "drop", sep = "_")
    data <- suppressMessages(read_csv(data.to.read[[i]])) %>% # should be i 
      dplyr::mutate(model = file.df$model[[j]]) %>% # should be J  NEED TO ADD METADATA FROM FILE NAME HERE
      dplyr::mutate(Metadata_Date = as.integer(file_metadata$Metadata_Date),
                    Metadata_Experiment = file_metadata$Metadata_Experiment,
                    Metadata_Plate = as.integer(stringr::str_replace(file_metadata$Metadata_Plate, pattern = "p", replacement = "")),
                    Metadata_Magnification = file_metadata$Metadata_Magnification,
                    Metadata_Well = file_metadata$Metadata_Well)
    model.specific.data[[i]] <- data
  }
  model.specific.data.df <- do.call(rbind, model.specific.data) %>%
    dplyr::left_join(., metadata)
  df.name <- paste(file.df$model[[j]], "model.outputs", sep = ".")
  assign(df.name, model.specific.data.df)
  message(paste("Finished", file.df$model[[j]], "Output Data", sep = " "))
}

###################
### Save Output ###
###################
setwd(paste0(basedir, "/projects/", project, "/output_data/", as.character(args[1])))

if (arg_count == 2) {
  message(paste0("Saving aggregated Cellprofiler data to:", basedir, "/projects/", project, "/output_data/", as.character(args[1]), "/CellProfiler-Analysis_", as.character(args[1]), ".RData"))
  save(list = c(ls(pattern = "model.outputs")), 
       file = paste0("CellProfiler-Analysis_", as.character(args[1]), ".RData"))
} else if (arg_count == 3) {
  message(paste0("Saving aggregated Cellprofiler data to:", basedir, "/projects/", project, "/output_data/", as.character(args[1]), "/CellProfiler-Analysis_", as.character(args[1]), as.character(args[3]), ".RData"))
  save(list = c(ls(pattern = "model.outputs")), 
       file = paste0("CellProfiler-Analysis_", as.character(args[1]), as.character(args[3]), ".RData"))
}