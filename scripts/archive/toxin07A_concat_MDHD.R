# /usr/bin/Rscript

# Toxin 7A
require(tidyverse)
require(reshape2)
setwd("/projects/b1059/software/CellProfiler/projects/20200313_toxin07A/output_data/20200313_toxin07A_summary_data/NonOverlappingWorms_Data")

high.dose.model.outputs <- list.files(pattern = "NonOverlappingWorms_MDHD.csv") %>%
  purrr::map(read.csv) %>%
  dplyr::bind_rows() %>%
  mutate(model = "MDHD")%>%
  dplyr::left_join(readr::read_csv("/projects/b1059/software/CellProfiler/metadata/20200313_toxin07A_metadata.csv") %>%
                     dplyr::mutate(Metadata_Plate = as.integer(Metadata_Plate)))

full.dose.model.outputs <- list.files(pattern = "NonOverlappingWorms_full.csv") %>%
  purrr::map(read.csv) %>%
  dplyr::bind_rows() %>%
  mutate(model = "full")%>%
  dplyr::left_join(readr::read_csv("/projects/b1059/software/CellProfiler/metadata/20200313_toxin07A_metadata.csv") %>%
                     dplyr::mutate(Metadata_Plate = as.integer(Metadata_Plate)))

control.model.outputs <- list.files(pattern = "NonOverlappingWorms_control.csv") %>%
  purrr::map(read.csv) %>%
  dplyr::bind_rows() %>%
  mutate(model = "control")%>%
  dplyr::left_join(readr::read_csv("/projects/b1059/software/CellProfiler/metadata/20200313_toxin07A_metadata.csv") %>%
                     dplyr::mutate(Metadata_Plate = as.integer(Metadata_Plate)))

setwd("/projects/b1059/software/CellProfiler/projects/20200313_toxin07A/output_data/20200313_toxin07A_summary_data")
save.image("toxin07A_MDHD.RData")
