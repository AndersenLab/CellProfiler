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
echo "LOG:     Number of Images in ${PROJECT_TITLE} Project: ${NIMAGES}"

echo "
#########################################
## Loading singularity module on QUEST ##
#########################################
"
module load singularity

#echo"
####################################
## Build Singularity Image of CP: ##
####################################"
# singularity pull docker://cellprofiler/cellprofiler:3.1.9

echo "
#####################################################
## Setting base directories for project/experiment ##
#####################################################
"
#BATCH=${CPBIN}/batch_files/Batch_data.h5

echo "
############################################
## Making image-specific output directory ##
############################################
"
IMAGE_INDEX=$1
IMAGE=$(ls ${IMAGES} | head -${IMAGE_INDEX} | tail -1)
OUTPUT_HEADER=$(echo ${IMAGE} | cut -f1-5 -d "_" | cut -f1 -d ".")
mkdir ${OUTPUT_DATA}/${OUTPUT_HEADER}.out

echo "
############################
## Executing cellprofiler ##
############################
"
singularity exec -B ${CPBIN}:${HOME} ${CPBIN}/cellprofiler_3.1.9.sif \
cellprofiler -c -r -p ${BATCH} \
  -f $1 \
  -l $1 \
  -o ${OUTPUT_DATA}/${OUTPUT_HEADER}.out

echo "
#####################################################
## Moving Output Data Files to Summary Data Folder ##
#####################################################
"
cd ${OUTPUT_DATA}/${OUTPUT_HEADER}.out/output_data
for file in NonOverlappingWorms_*.csv; \
do
  mv $file ${OUTPUT_HEADER}_$file; \
  mv ${OUTPUT_HEADER}_$file ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data; \
done

for file in OverlappingWorms_*.csv; \
do
  mv $file ${OUTPUT_HEADER}_$file; \
  mv ${OUTPUT_HEADER}_$file ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/OverlappingWorms_Data; \
done

echo "
#######################################################
## Moving Processed Images to Project Summary Folder ##
#######################################################
"
cd ${OUTPUT_DATA}/${OUTPUT_HEADER}.out/images
mv processed_images/${OUTPUT_HEADER}_overlay.png       ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/ProcessedImages

echo "
################################################
## Moving Log Files to Project Summary Folder ##
################################################
"
cd ${OUTPUT_DATA}/${OUTPUT_HEADER}.out/output_data
for file in Experiment.csv; \
do
  mv $file ${OUTPUT_HEADER}_$file; \
  mv ${OUTPUT_HEADER}_$file ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/Logs; \
done

for file in Image.csv; \
do
  mv $file ${OUTPUT_HEADER}_$file; \
  mv ${OUTPUT_HEADER}_$file ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/Logs; \
done

for file in Welloutline.csv; \
do
  mv $file ${OUTPUT_HEADER}_$file; \
  mv ${OUTPUT_HEADER}_$file ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/Logs; \
done

for file in WormObjects.csv; \
do
  mv $file ${OUTPUT_HEADER}_$file; \
  mv ${OUTPUT_HEADER}_$file ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/Logs; \
done

echo "
####################################
## Removing Temporary Directories ##
####################################
"
cd ${OUTPUT_DATA}
rm -r ${OUTPUT_DATA}/${OUTPUT_HEADER}.out
