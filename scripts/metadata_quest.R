#!/usr/bin/env Rscript --vanilla

args = commandArgs(trailingOnly=TRUE)
args = "projects/20190926_drugresponse/"
# test if there is at least one argument: if not, return an error
if (length(args)==0) { 
  stop("At least one argument must be supplied (input file).n", call.=FALSE) 
} else { 
    print(args) 
  }

# Begin

install.packages("gtools")
install.packages("reshape2")
# require(tidyr)  
# require(dplyr)  
CPBIN_path <- "/projects/b1059/software/CellProfiler/"
PROJECT_path <- paste(CPBIN_path,args,sep = "")
IMAGE_path <- paste(PROJECT_path,"raw_images",sep = "")
print(IMAGE_path)
list.files(IMAGE_path)

# ###################
# # Image File Path #
# ###################
# Image_FileName_RawBF <- data.frame(list.files("raw_images/"))
# colnames(Image_FileName_RawBF) <- c("Image_FileName_RawBF")
# Image_FileName_RawBF$path.copy <- Image_FileName_RawBF$Image_FileName_RawBF
# images <- tidyr::separate(data = Image_FileName_RawBF, 
#                           col = path.copy, 
#                           into = c("date","experiment","plate","magnification","end"), 
#                           sep = "_")
# images <- tidyr::separate(data = images, 
#                           col = end, 
#                           into = c("well","TIF"))
# images <- images[,-ncol(images)]
# images$Image_PathName_RawBF <- "/projects/b1059/software/CellProfiler/projects/20190926_drugresponse/raw_images" ## CLUSTER
# # images$Image_PathName_RawBF <- "images/raw_images/20190926_drugresponse/" ## LOCAL
# images <- images %>% dplyr::select(Image_FileName_RawBF, Image_PathName_RawBF, date, experiment, plate, magnification, well)
# 
# #######################
# # Well Mask File Path #
# #######################
# images$Image_PathName_wellmask_98.png <- "/projects/b1059/software/CellProfiler/well_masks/" ## CLUSTER
# # images$Image_PathName_wellmask_98.png <- "images/well_masks/" ## LOCAL
# images$Image_FileName_wellmask_98.png <- "wellmask_98.png"
# colnames(images) <- c(colnames(images)[1:2], 
#                       "Metadata_Date",
#                       "Metadata_Experiment",
#                       "Metadata_Plate",
#                       "Metadata_Magnification",
#                       "Metadata_Well",
#                       colnames(images)[8:9])
# 
# ########################
# # Export Metadata File #
# ########################
# filename <- paste(paste(images$Metadata_Date, 
#                         images$Metadata_Experiment, sep = "_")[1],
#                   "metadata",
#                   sep = "_")
# write.csv(x = images,
#           file = paste("metadata/",filename,".csv",sep = ""), 
#           row.names = F)
