#!/bin/bash

# To run from within /projects/b1059/software/CellProfiler:
# bash scripts/run.cell.profiler.sh projects/20190926_drugresponse batch_files/batch_file.h5
# bash scripts/concatenate.triplepipeline.results.sh projects/20190926_drugresponse

export CPBIN=/projects/b1059/software/CellProfiler
export PROJECT_ID=$1
export BATCH=$2
export IMAGES=${CPBIN}/${PROJECT_ID}/raw_images/
export PROJECT_TITLE=$(echo ${PROJECT_ID} | cut -f2 -d "/")
export NIMAGES=$(ls ${IMAGES} | wc -l)

if [ ! -d ${CPBIN}/${PROJECT_ID}/output_data ]; then
    echo "LOG:     CellProfiler Output Directory Not Found :/" ;
    echo "LOG:     Creating CellProfiler Analysis Output Directory" ;
    mkdir ${CPBIN}/${PROJECT_ID}/output_data ; else
    echo "LOG:     CellProfiler Analysis Output Directory Exists - Nice!" ;
fi
export OUTPUT_DATA=${CPBIN}/${PROJECT_ID}/output_data

mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data
mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data
mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/OverlappingWorms_Data
mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/ProcessedImages
mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/Logs

COUNT=1; \
  for i in $(seq $NIMAGES); \
  do sbatch ${CPBIN}/scripts/cellprofiler.SW.20200113.sh $i; \
  let COUNT=$COUNT+1; \
done
