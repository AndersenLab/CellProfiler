# /usr/bin/Rscript

########################
### Script Arguments ###
########################
# [1] = Assay Name in Project Directory i.e. 20200626_toxin08B
args <- commandArgs(trailingOnly = TRUE)
require(tidyverse)
basedir <- c("/projects/b1059/software/CellProfiler/")
setwd(paste(basedir, 
            "projects/", 
            as.character(args[1]), 
            "/raw_images",
            sep = "")) 

###################
# Image File Path #
###################
Image_FileName_RawBF <- data.frame(list.files())
colnames(Image_FileName_RawBF) <- c("Image_FileName_RawBF")
Image_FileName_RawBF$path.copy <- Image_FileName_RawBF$Image_FileName_RawBF
images <- Image_FileName_RawBF %>% 
  tidyr::separate(col = path.copy, 
                  into = c("plate","experiment","hour","magnification"), 
                  sep = "-") %>%
  tidyr::separate(col = magnification, 
                  into = c("magnification","well"),
                  sep = "_") %>%
  tidyr::separate(col = well, 
                  into = c("well","TIF"),
                  sep = "[.]") %>%
  dplyr::select(-TIF)



images$Image_PathName_RawBF <- paste(basedir,"projects/",as.character(args[1]),"/raw_images", sep = "") ## CLUSTER
images <- images %>% 
  dplyr::select(Image_FileName_RawBF, Image_PathName_RawBF, plate, experiment, hour, magnification, well)

#######################
# Well Mask File Path #
#######################
images$Image_PathName_wellmask_98.png <- paste(basedir,"well_masks/",sep = "") ## CLUSTER
images$Image_FileName_wellmask_98.png <- "wellmask_98.png"
colnames(images) <- c(colnames(images)[1:2], 
                      "Metadata_Plate",
                      "Metadata_Experiment",
                      "Metadata_Hour",
                      "Metadata_Magnification",
                      "Metadata_Well",
                      colnames(images)[8:9])

########################
# Export Metadata File #
########################
today <- format(Sys.time(), '%Y%m%d')
filename <- paste(as.character(args[1]),
                  "metadata",
                  today,
                  sep = "_")
setwd(paste(basedir,"metadata",sep = ""))
write.csv(x = images, file = paste(filename,".csv",sep = ""), row.names = F)
