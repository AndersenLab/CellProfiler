#!/bin/bash

# To run:
# bash scripts/run.cell.profiler.sh projects/20190926_drugresponse/

export PROJECT_ID=$1
export CPBIN=/projects/b1059/software/CellProfiler
export IMAGES=${PROJECT_ID}/raw_images/
echo "Home Directory: ${HOME}"
echo "Path to CellProfiler Software: ${CPBIN}"

NIMAGES=$(ls ${IMAGES} | wc -l)
echo "LOG:     Begin CellProfiler Analysis"
echo "LOG:     Number of Images: ${NIMAGES}"

export PROJECT_TITLE=$(echo ${PROJECT_ID} | cut -f2 -d "/")
echo "LOG:     Project Title: ${PROJECT_TITLE}"

if [ ! -d ${PROJECT_ID}/cellprofiler_output_data ]; then
    echo "LOG:     CellProfiler Output Directory Not Found :/" ;
    echo "LOG:     Creating CellProfiler Analysis Output Directory" ;
    mkdir ${PROJECT_ID}/cellprofiler_output_data ;
fi

export OUTPUT_DATA=${PROJECT_ID}/cellprofiler_output_data
mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data

#COUNT=1; \
#for i in $(seq $NIMAGES); \
#  do sbatch ${CPBIN}/scripts/cellprofiler.20191204.sh $i; \
#  let COUNT=$COUNT+1; \
#done

# NEXT STEP IN PIPELINE
# random file to pull table header from
# NONOVERLAPPING_SUM_DATA_HEADER=$(ls output_data/${PROJECT_TITLE}_summary_data/*_NonOverlappingWorms_control.csv | head -n 1)
# OVERLAPPING_SUM_DATA_HEADER=$(ls output_data/${PROJECT_TITLE}_summary_data/*_OverlappingWorms_control.csv | head -n 1)

# head -n 1 ${NONOVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_control.csv
# tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_NonOverlappingWorms_control.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_control.csv

# head -n 1 ${NONOVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_full_csv
# tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_NonOverlappingWorms_full.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_full_csv

# head -n 1 ${NONOVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_highdose.csv
# tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_NonOverlappingWorms_high_dose.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_nonoverlapping_highdose.csv

# head -n 1 ${OVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_control.csv
# tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_OverlappingWorms_control.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_control.csv

# head -n 1 ${OVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_full.csv
# tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_OverlappingWorms_full.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_full.csv

# head -n 1 ${OVERLAPPING_SUM_DATA_HEADER} > ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_highdose.csv
# tail -n+2 -q output_data/${PROJECT_TITLE}_summary_data/*_OverlappingWorms_high_dose.csv >> ${PROJECT_TITLE}_summary_data/${PROJECT_TITLE}_overlapping_highdose.csv
