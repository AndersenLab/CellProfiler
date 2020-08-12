# /usr/bin/Rscript

# Toxin 8A
require(tidyverse)
require(reshape2)
setwd("/projects/b1059/software/CellProfiler/projects/20200625_toxin08A/output_data/20200625_toxin08A_summary_data/NonOverlappingWorms_Data")
metadata <- read_csv("/projects/b1059/software/CellProfiler/metadata/20200625_toxin08A_metadata.csv")

#################
### High Dose ###
#################
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

setwd("/projects/b1059/software/CellProfiler/projects/20200625_toxin08A/output_data/20200625_toxin08A_summary_data")
save.image("toxin08A_high.RData")
