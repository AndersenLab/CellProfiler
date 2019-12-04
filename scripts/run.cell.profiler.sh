#!/bin/bash

# To run:
# bash scripts/run.cell.profiler.sh images/raw_images/20190926_drugresponse/

export PROJECT_ID=$1
NIMAGES=$(ls ${PROJECT_ID}/ | wc -l)
export PROJECT_TITLE=$(echo ${PROJECT_ID} | cut -f3 -d "/")
mkdir output_data/${PROJECT_TITLE}_summary_data
mkdir ${PROJECT_TITLE}_summary_data

COUNT=1; \
for i in $(seq $NIMAGES); \
  do sbatch scripts/cellprofiler.20191204.sh $i; \
  let COUNT=$COUNT+1; \
done

# random file to pull table header from
NONOVERLAPPING_SUM_DATA_HEADER=$(ls output_data/${PROJECT_TITLE}_summary_data/*_NonOverlappingWorms_control.csv | head -n 1)
OVERLAPPING_SUM_DATA_HEADER=$(ls output_data/${PROJECT_TITLE}_summary_data/*_OverlappingWorms_control.csv | head -n 1)

head -n 1 ${NONOVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_control.csv
tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_NonOverlappingWorms_control.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_control.csv

head -n 1 ${NONOVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_full_csv
tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_NonOverlappingWorms_full.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_full_csv

head -n 1 ${NONOVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_highdose.csv
tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_NonOverlappingWorms_high_dose.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_highdose.csv

head -n 1 ${OVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_control.csv
tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_OverlappingWorms_control.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_control.csv

head -n 1 ${OVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_full.csv
tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_OverlappingWorms_full.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_full.csv

head -n 1 ${OVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_highdose.csv
tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_OverlappingWorms_high_dose.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_highdose.csv
