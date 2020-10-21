# /usr/bin/Rscript

########################
### Script Arguments ###
########################
# [1] = Assay Name in Project Directory i.e. 20200626_toxin08B
args <- commandArgs(trailingOnly = TRUE)
require(tidyverse)
<<<<<<< HEAD
basedir <-paste0(getwd(),"/")
setwd(paste(basedir, "projects/", as.character(args[1]), "/raw_images", sep = ""))
=======
basedir <- getwd()

setwd(paste0(basedir, "/projects/", as.character(args[1]), "/raw_images"))
>>>>>>> f55042fa8cc3f7ff38bfede596597d1aae9157f4

###################
# Image File Path #
###################
Image_FileName_RawBF <- data.frame(list.files(pattern = "*.TIF"))
colnames(Image_FileName_RawBF) <- c("Image_FileName_RawBF")
Image_FileName_RawBF$path.copy <- Image_FileName_RawBF$Image_FileName_RawBF
images <- Image_FileName_RawBF %>% 
  tidyr::separate(col = path.copy, 
                  into = c("date","experiment","plate","magnification"), 
                  sep = "-") %>%
  tidyr::separate(col = magnification, 
                  into = c("magnification","well"),
                  sep = "_") %>%
  tidyr::separate(col = well, 
                  into = c("well","TIF"),
                  sep = "[.]") %>%
  dplyr::select(-TIF)



images$Image_PathName_RawBF <- paste(basedir,"/projects/",as.character(args[1]),"/raw_images", sep = "") ## CLUSTER
images <- images %>% 
  dplyr::select(Image_FileName_RawBF, Image_PathName_RawBF, date, experiment, plate, magnification, well)

#######################
# Well Mask File Path #
#######################
images$Image_PathName_wellmask_98.png <- paste(basedir,"/well_masks/",sep = "") ## CLUSTER
images$Image_FileName_wellmask_98.png <- "wellmask_98.png"
colnames(images) <- c(colnames(images)[1:2], 
                      "Metadata_Date",
                      "Metadata_Experiment",
                      "Metadata_Plate",
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
setwd(paste0(basedir, "/metadata"))
write.csv(x = images, file = paste(filename,".csv",sep = ""), row.names = F)

