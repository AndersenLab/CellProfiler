# /usr/bin/Rscript

# Toxin 1B
require(tidyverse)
require(reshape2)
setwd("/projects/b1059/software/CellProfiler/projects/20200131_toxin01/output_data/20200131_toxin01_summary_data/NonOverlappingWorms_Data/")
high.dose.model.outputs <- list.files(pattern = "NonOverlappingWorms_high.csv") %>% 
      purrr::map(read.csv) %>%
      dplyr::bind_rows() %>%
      mutate(model = "high")

full.dose.model.outputs <- list.files(pattern = "NonOverlappingWorms_full.csv") %>% 
      purrr::map(read.csv) %>%
      dplyr::bind_rows() %>%
      mutate(model = "full")

control.model.outputs <- list.files(pattern = "NonOverlappingWorms_control.csv") %>% 
      purrr::map(read.csv) %>%
      dplyr::bind_rows() %>%
      mutate(model = "control")

toxin01B_combined <- dplyr::bind_rows(
      high.dose.model.outputs,
      full.dose.model.outputs,
      control.model.outputs
)
setwd("/projects/b1059/software/CellProfiler/projects/20200131_toxin01/output_data/20200131_toxin01_summary_data/")
save.image("toxin01B.RData")










