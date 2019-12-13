library(tidyverse)

# CellProfiler LoadData File Prep
setwd("/Users/sam/Desktop/sam/cellprofiler/")

Image_FileName_RawBF <- data.frame(list.files("NAS_raw_images/20190926_drugresponse/"))
colnames(Image_FileName_RawBF) <- c("Image_FileName_RawBF")
Image_FileName_RawBF$path.copy <- Image_FileName_RawBF$Image_FileName_RawBF
images <- tidyr::separate(data = Image_FileName_RawBF, 
                          col = path.copy, 
                          into = c("date","experiment","plate","magnification","end"), 
                          sep = "_")
images <- tidyr::separate(data = images, 
                          col = end, 
                          into = c("well","TIF"))
images <- images[,-ncol(images)]
images$Image_PathName_RawBF <- "NAS_raw_images/20190926_drugresponse/"


images <- images %>% dplyr::select(Image_FileName_RawBF, Image_PathName_RawBF, date, experiment, plate, magnification, well)
images$Image_PathName_wellmask_98.png <- "well_masks/"
images$Image_FileName_wellmask_98.png <- "wellmask_98.png"
colnames(images) <- c(colnames(images)[1:2], 
                      "Image_Metadata_Date",
                      "Image_Metadata_Experiment",
                      "Image_Metadata_Plate",
                      "Image_Metadata_Magnification",
                      "Image_Metadata_Well",
                      colnames(images)[8:9])

filename <- paste(paste(images$Image_Metadata_Date, images$Image_Metadata_Experiment, sep = "_")[1],
                  "metadata",
                  sep = "_")
write.csv(x = images[1:5,], file = paste(filename,".csv",sep = ""), row.names = F)
