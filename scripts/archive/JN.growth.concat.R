# /usr/bin/Rscript

# Joy Growth Time Course Assay
require(tidyverse)
require(reshape2)
setwd("/projects/b1059/software/CellProfiler/projects/20191119_growth/output_data/20191119_growth_summary_data/NonOverlappingWorms_Data")

L1.dose.model.outputs <- list.files(pattern = "L1_NonOverlappingWorms") %>% 
      purrr::map(read.csv) %>%
      dplyr::bind_rows() %>%
      mutate(model = "L1")

L2L3.dose.model.outputs <- list.files(pattern = "L2L3_NonOverlappingWorms") %>% 
      purrr::map(read.csv) %>%
      dplyr::bind_rows() %>%
      mutate(model = "L2L3")

L4.model.outputs <- list.files(pattern = "L4_NonOverlappingWorms.csv") %>% 
      purrr::map(read.csv) %>%
      dplyr::bind_rows() %>%
      mutate(model = "L4")

adult.model.outputs <- list.files(pattern = "adult_NonOverlappingWorms.csv") %>% 
   purrr::map(read.csv) %>%
   dplyr::bind_rows() %>%
   mutate(model = "adult")

)
setwd("/projects/b1059/software/CellProfiler/projects/20191119_growth/output_data/20191119_growth_summary_data")
save.image("20191119_growth.RData")










