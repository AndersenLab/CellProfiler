#!/bin/bash
#SBATCH -A b1042                    # Allocation
#SBATCH -p genomicsguestA           # Queue
#SBATCH -t 12:00:00                 # Walltime/duration of the job
#SBATCH -N 1                        # Number of Nodes
#SBATCH --job-name="CellProfiler"   # Name of job

#########################
## Cell Profiler 3.1.9 ##
#########################

# To build Singularity Image of CP:
# singularity pull docker://cellprofiler/cellprofiler:3.1.9

# Load singularity module on QUEST
module load singularity

# Set base directories for project/experiment
BATCH=${CP_BIN}/batch_files/Batch_data.h5

# Make image-specific output directory
IMAGE_INDEX=$1
IMAGE=$(ls ${IMAGES} | head -${IMAGE_INDEX} | tail -1)
OUTPUT_HEADER=$(echo ${IMAGE} | cut -f1-5 -d "_" | cut -f1 -d ".")
mkdir ${OUTPUT_DATA}/${OUTPUT_HEADER}.out

# Execute cellprofiler
#singularity exec -B ${CP_BIN}:${HOME} cellprofiler_3.1.9.sif \
#cellprofiler -c -r -p ${BATCH} \
#-f $1 \
#-l $1 \
#-o ${OUTPUT_DATA}/${OUTPUT_HEADER}.out

# Move output data files to summary data folder
# mv ${BASE_PATH}/output_data/${OUTPUT_HEADER}.out/output_data/dual_modelNonOverlappingWorms_control.csv ${BASE_PATH}/output_data/${PROJECT_TITLE}_summary_data/${OUTPUT_HEADER}_NonOverlappingWorms_control.csv
# mv ${BASE_PATH}/output_data/${OUTPUT_HEADER}.out/output_data/dual_modelNonOverlappingWorms_full.csv ${BASE_PATH}/output_data/${PROJECT_TITLE}_summary_data/${OUTPUT_HEADER}_NonOverlappingWorms_full.csv
#
# mv ${BASE_PATH}/output_data/${OUTPUT_HEADER}.out/output_data/dual_modelOverlappingWorms_control.csv ${BASE_PATH}/output_data/${PROJECT_TITLE}_summary_data/${OUTPUT_HEADER}_OverlappingWorms_control.csv
# mv ${BASE_PATH}/output_data/${OUTPUT_HEADER}.out/output_data/dual_modelOverlappingWorms_full.csv ${BASE_PATH}/output_data/${PROJECT_TITLE}_summary_data/${OUTPUT_HEADER}_OverlappingWorms_full.csv
# mv ${BASE_PATH}/output_data/${OUTPUT_HEADER}.out/output_data/dual_modelOverlappingWorms_high_dose.csv ${BASE_PATH}/output_data/${PROJECT_TITLE}_summary_data/${OUTPUT_HEADER}_OverlappingWorms_high_dose.csv
