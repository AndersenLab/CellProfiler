library(ggplot2)
library(tidyverse)
library(reshape2)

### Comparing CellProfiler Pipeline Outputs ###
setwd("~/Desktop/sam/cellprofiler/NAS_processed_images/projects/20190926_drugresponse_RUN02/")

# Tim Pipeline Adapted for CP3.0
TACdata <- read.csv("data/dual_modelNonOverlappingWorms_full.csv") %>%
  dplyr::select(ImageNumber, 
                ObjectNumber, 
                Metadata_ChannelNumber, 
                Worm_Length)
TACdata$pipeline <- "TAC"

# Sam Pipeline Adapted for 
SJWdata <- read.csv("data_SJW/dual_modelNonOverlappingWorms_full.csv") %>%
  dplyr::select(ImageNumber, 
                ObjectNumber,
                Worm_Length)
SJWdata$pipeline <- "SJW"
SJWdata$Metadata_ChannelNumber <- TACdata$Metadata_ChannelNumber

qplot(TACdata$Worm_Length, SJWdata$Worm_Length, 
      alpha = 0.01, size = 4) + 
  theme_bw() + 
  ylab("Sam's Pipeline: Worm Length") + 
  xlab("Tim's Pipeline: Worm Length") + 
  theme(legend.position = "none") + 
  geom_abline(slope = 1)
ggsave(filename = "Tim.v.Sam.pdf", 
       path = "~/Desktop/sam/cellprofiler/", height = 4, width = 5.5)




