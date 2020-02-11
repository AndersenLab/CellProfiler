require(tidyverse)
setwd("/Volumes/ECA_Image/Tim/20200131_Toxin01B/20200131-toxin01B/")

###################
# Image File Path #
###################
Image_FileName_RawBF <- data.frame(list.files())
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



images$Image_PathName_RawBF <- "/projects/b1059/software/CellProfiler/projects/20200131_toxin01/raw_images" ## CLUSTER
# images$Image_PathName_RawBF <- "images/raw_images/20190926_drugresponse/" ## LOCAL
images <- images %>% 
  dplyr::select(Image_FileName_RawBF, Image_PathName_RawBF, date, experiment, plate, magnification, well)

#######################
# Well Mask File Path #
#######################
images$Image_PathName_wellmask_98.png <- "/projects/b1059/software/CellProfiler/well_masks/" ## CLUSTER
# images$Image_PathName_wellmask_98.png <- "images/well_masks/" ## LOCAL
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
filename <- paste(paste(images$Metadata_Date, 
                        images$Metadata_Experiment, sep = "_")[1],
                  "metadata",
                  sep = "_")
write.csv(x = images,
          file = paste(filename,".csv",sep = ""), 
          row.names = F)
