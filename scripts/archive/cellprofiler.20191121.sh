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
BASE_PATH=/projects/b1059/projects/Sam/CellProfiler
BATCH=${BASE_PATH}/batch_files/Batch_data.h5

# Make image-specific output directory
IMAGE_INDEX=$1
IMAGE=$(ls ${PROJECT_ID} | head -${IMAGE_INDEX} | tail -1)
OUTPUT_HEADER=$(echo ${IMAGE} | cut -f1-5 -d "_" | cut -f1 -d ".")
mkdir ${BASE_PATH}/output_data/${OUTPUT_HEADER}.out

# Execute cellprofiler
singularity exec -B ${BASE_PATH}:${HOME} cellprofiler_3.1.9.sif \
cellprofiler -c -r -p ${BATCH} \
-f $1 \
-l $1 \
-o ${BASE_PATH}/output_data/${OUTPUT_HEADER}.out
