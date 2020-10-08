#!/bin/bash

# To run from within CellProfiler directory:
# bash scripts/check_run_cellprofiler.sh projects/[your_project_directory] batch_files/[your_batch_file] [your_output_data_time_stamp] [your_cellprofiler_version_.sif_file]

#export COMMAND=$($0 $*)
export COMD_RUN=$@ # Nic 20201004
export PROJECT_ID=$1
export BATCH=$2
export STAMP=$3
export CPBIN=$(pwd)
export IMAGES=${CPBIN}/${PROJECT_ID}/raw_images/
export NIMAGES=$(ls ${IMAGES} | grep /*.TIF | wc -l) # match only .TIF files and count them
export OUTPUT_DATA=${CPBIN}/${PROJECT_ID}/output_data
export PROJECT_TITLE=$(echo ${PROJECT_ID} | cut -f2 -d "/")
export CP_SIF=${4-cellprofiler_4.0.3.sif} # set argument 4 to latest cellprofiler version if not specified

# Report which version is running
echo -e "Running with "${CP_SIF}"\n"

# Extract image metadata from all file names in IMAGES directory
echo -e "Extracting metadata from raw image files\n"
IMG_META=$(for f in `ls ${IMAGES} | grep /*.TIF`; do
	 match="${f%%.TIF}";
	 echo ${match};
done) 

# need to check if ${IMAGES}not_processed.tsv exists. If it does already then we need to remove it so we don't add duplicates
if test -f ${IMAGES}not_processed.tsv; then
    echo -e "Removing existing file: "${IMAGES}not_processed.tsv"\n";
    rm ${IMAGES}not_processed.tsv;
fi

# need to check if ${IMAGES}nimage_not_processed.tsv exists. If it does already then we need to remove it so we don't add duplicates
if test -f ${IMAGES}nimage_not_processed.tsv; then
    echo -e "Removing existing file: "${IMAGES}nimage_not_processed.tsv"\n";
    rm ${IMAGES}nimage_not_processed.tsv;
fi

# Go to output directory "NonOverlappingWorms_Data"
# and add all files without an output to not_processed.tsv in IMAGES directory
echo -e "Checking for images not processed correctly. This might take a few minutes.\n"
cd ${OUTPUT_DATA}/${PROJECT_TITLE}_data_${STAMP}/NonOverlappingWorms_Data/
for i in ${IMG_META}; do
	 shopt -s nullglob;
	 set -- "$i"*;
	 if [ "$#" -eq 0 ]; then
  		 echo "$i.TIF" | cat >> ${IMAGES}not_processed.tsv;
	 fi;
done

# Go back to base directory
cd ${CPBIN}

# Test if not_processed.tsv was written to IMAGES directory
if test -f ${IMAGES}not_processed.tsv; then
    # Count number  of images in not_processed.tsv file
    N_NOT_PROCESSED=$(cat ${IMAGES}not_processed.tsv | wc -l);
    # Report the number of images not procesed
    if [ ${N_NOT_PROCESSED} -eq 1 ]; then
        echo -e "Looks like 1 file was not processed completely.\n";
        echo -e "We'll try to reprocess it for ya, hold a bit."; else    
        echo -e "Looks like "$(($N_NOT_PROCESSED))" files were not processed completely.\n";
        echo -e "We'll try to reprocess those for ya, hold a bit."; # let em know there's a extra
    fi;
    # Find the right image numbers to pass to cellproiler
    # get tsv with row numbers in matching each file name in not_processed.tsv
    grep -w -F -f ${IMAGES}not_processed.tsv ${IMAGES}nimage_names.tsv > ${IMAGES}nimage_not_processed.tsv

    # get sequence of numbers
    REPROCESS_IMAGE_NUMS=$(awk '{ print $1 }' ${IMAGES}nimage_not_processed.tsv)
    
    # Send these files back to CellProfiler script for reprocessing.    
    for i in ${REPROCESS_IMAGE_NUMS};
        do
        sbatch ${CPBIN}/scripts/cellprofiler_parallel_bigmem_NEW.sh $i 2;
    done
    else
        # Report the good news
        echo -e "GREAT NEWS! All images appear to be processed correctly."
fi