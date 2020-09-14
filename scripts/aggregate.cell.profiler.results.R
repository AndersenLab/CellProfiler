# /usr/bin/Rscript

################################
### Script Arguments & Setup ###
################################
# [1] = Assay Name in Project Directory i.e. 20200626_toxin08B
# [2] = Output Info
# [3] = Metadata Filename
args <- commandArgs(trailingOnly = TRUE)
require(tidyverse)
basedir <- c("/projects/b1059/software/CellProfiler/")
setwd(paste(basedir, 
            "projects/", 
            as.character(args[1]), 
            "/output_data/", 
            paste(as.character(args[1]), "summary_data", sep = "_"),
            "/NonOverlappingWorms_Data", sep = ""))

#####################
### Read Metadata ###
#####################
metadata <- readr::read_csv(paste(basedir,"metadata/",as.character(args[3]), sep = "")) %>%
  dplyr::mutate(Metadata_Plate = as.integer(Metadata_Plate)) %>% # plates begin with "p"
  dplyr::mutate(Metadata_Date = as.integer(Metadata_Date))

################################
### Aggregate CP Output Data ###
################################
files <- list.files(pattern = "NonOverlappingWorms")
file.df <- data.frame(do.call(rbind, as.list(files))) %>%
  `colnames<-`(c("filename")) %>%
  tidyr::separate(col = filename, into = c("header","csv"), sep = "[.]", remove = F) %>%
  tidyr::separate(col = header, into = c("plate","well","output","model"), sep = "_") %>%
  dplyr::select(filename, model) %>%
  dplyr::group_by(model) %>%
  tidyr::nest()
for(j in 1:length(file.df$data)){
  x <- file.df$data[[j]]
  data.to.read <- as.character(x$filename)
  model.specific.data <- list()
  for(i in 1:length(data.to.read)){
    data <- suppressMessages(read_csv(data.to.read[[i]])) %>%
      dplyr::mutate(model = file.df$model[[j]]) %>%
      dplyr::mutate(Metadata_Plate = as.integer(Metadata_Plate)) %>% # plates begin with "p"
      dplyr::mutate(Metadata_Date = as.integer(Metadata_Date))
    model.specific.data[[i]] <- data
  }
  print(paste("Generating", file.df$model[[j]], "Output Data", sep = " "))
  model.specific.data.df <- do.call(rbind, model.specific.data) %>%
    dplyr::left_join(., metadata)
  df.name <- paste(file.df$model[[j]], "model.outputs", sep = ".")
  assign(df.name, model.specific.data.df)
  print(paste("Finished", file.df$model[[j]], "Output Data", sep = " "))
}

###################
### Save Output ###
###################
setwd(paste(basedir, "projects/", as.character(args[1]), "/output_data/", paste(as.character(args[1]), "summary_data", sep = "_"), sep = ""))
today <- format(Sys.time(), '%Y%m%d')
save(list = c(ls(pattern = "model.outputs")), 
     file = paste("CellProfiler-Analysis_",args[1],"_",as.character(args[2]),"_",today,".RData",sep = ""))

