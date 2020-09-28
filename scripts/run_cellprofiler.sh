#!/bin/bash

# To run from within CellProfiler directory:
# bash scripts/run_cellprofiler.sh projects/[your_project_directory] batch_files/[your_batch_file] [your_cellprofiler_version_.sif_file]

export PROJECT_ID=$1
export BATCH=$2
export CPBIN=$(pwd)
export IMAGES=${CPBIN}/${PROJECT_ID}/raw_images/
export PROJECT_TITLE=$(echo ${PROJECT_ID} | cut -f2 -d "/")
export STAMP=$(date +"%s") # get a unique time stamp for this analysis
export NIMAGES=$(ls ${IMAGES} | grep /*.TIF | wc -l) # match only .TIF files and count them
export CP_SIF=${3-cellprofiler_4.0.3.sif} # set argument 4 to latest cellprofiler version if not specified
# Report which version is running
echo -e "Running with "${CP_SIF}"\nTo run with another sif version use the optional forth argument\n"

# Check to see if there is an output folder for the project already. If not make one.
if [ ! -d ${CPBIN}/${PROJECT_ID}/output_data ]; then
    echo "LOG:     CellProfiler Output Directory Not Found :/" ;
    echo "LOG:     Creating CellProfiler Analysis Output Directory" ;
    mkdir ${CPBIN}/${PROJECT_ID}/output_data ; else
    echo "LOG:     CellProfiler Analysis Output Directory Exists - Nice!" ;
fi
export OUTPUT_DATA=${CPBIN}/${PROJECT_ID}/output_data

# make all the directories we need for cellprofiler_parallel_bigmem.sh
mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_data_${STAMP}
mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_data_${STAMP}/NonOverlappingWorms_Data
mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_data_${STAMP}/OverlappingWorms_Data
mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_data_${STAMP}/ProcessedImages
mkdir ${OUTPUT_DATA}/${PROJECT_TITLE}_data_${STAMP}/Logs

# Send files to cellprofiler_parallel_bigmem.sh for processing
COUNT=1; \
  for i in ===$(seq $NIMAGES); \
  do sbatch ${CPBIN}/scripts/cellprofiler_parallel_bigmem.sh $i 1; \
  let COUNT=$COUNT+1; \
done