#!/bin/bash
#SBATCH -A b1042                    # Allocation
#SBATCH -p genomicsguestA           # Queue
#SBATCH -t 12:00:00                 # Walltime/duration of the job
#SBATCH -N 1                        # Number of Nodes
#SBATCH --job-name="CellProfiler"   # Name of job

echo "
####  ####  #     #     ####  ####   ####  ####  ##  #     ####  ####
#     #     #     #     #  #  #  #   #  #  #     ##  #     #     #  #
#     ####  #     #     ####  ##     #  #  ###   ##  #     ####  ##
#     #     #     #     #     #  #   #  #  #     ##  #     #     #  #
####  ####  ####  ####  #     #  #   ####  #     ##  ####  ####  #  #
"
echo "CellProfiler Log"
echo "Home Directory: ${HOME}"
echo "Path to CellProfiler Software: ${CPBIN}"
echo "LOG:     Begin CellProfiler Analysis"
echo "LOG:     Project Title: ${PROJECT_TITLE}"
NIMAGES=$(ls ${IMAGES} | wc -l)
echo "LOG:     Number of Images in ${PROJECT_TITLE} Project: ${NIMAGES}"

# Load singularity module on QUEST
module load singularity

# Build Singularity Image of CP:
# singularity pull docker://cellprofiler/cellprofiler:3.1.9

# Set base directories for project/experiment
BATCH=${CPBIN}/batch_files/Batch_data.h5

# Make image-specific output directory
IMAGE_INDEX=$1
IMAGE=$(ls ${IMAGES} | head -${IMAGE_INDEX} | tail -1)
OUTPUT_HEADER=$(echo ${IMAGE} | cut -f1-5 -d "_" | cut -f1 -d ".")
mkdir ${OUTPUT_DATA}/${OUTPUT_HEADER}.out

# Execute cellprofiler
singularity exec -B ${CPBIN}:${HOME} ${CPBIN}/cellprofiler_3.1.9.sif \
cellprofiler -c -r -p ${BATCH} \
  -f $1 \
  -l $1 \
  -o ${OUTPUT_DATA}/${OUTPUT_HEADER}.out

# Move output data files to summary data folder
mv ${OUTPUT_DATA}/${OUTPUT_HEADER}.out/output_data/dual_modelNonOverlappingWorms_control.csv ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms/${OUTPUT_HEADER}_NonOverlappingWorms_control.csv
mv ${OUTPUT_DATA}/${OUTPUT_HEADER}.out/output_data/dual_modelNonOverlappingWorms_full.csv    ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms/${OUTPUT_HEADER}_NonOverlappingWorms_full.csv
mv ${OUTPUT_DATA}/${OUTPUT_HEADER}.out/output_data/dual_modelNonOverlappingWorms_high.csv    ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms/${OUTPUT_HEADER}_NonOverlappingWorms_high.csv

mv ${OUTPUT_DATA}/${OUTPUT_HEADER}.out/output_data/dual_modelOverlappingWorms_control.csv ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/OverlappingWorms/${OUTPUT_HEADER}_OverlappingWorms_control.csv
mv ${OUTPUT_DATA}/${OUTPUT_HEADER}.out/output_data/dual_modelOverlappingWorms_full.csv    ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/OverlappingWorms/${OUTPUT_HEADER}_OverlappingWorms_full.csv
mv ${OUTPUT_DATA}/${OUTPUT_HEADER}.out/output_data/dual_modelOverlappingWorms_high.csv    ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/OverlappingWorms/${OUTPUT_HEADER}_OverlappingWorms_high.csv
