#!/bin/bash

export CPBIN=/projects/b1059/software/CellProfiler
export PROJECT_ID=$1
export IMAGES=${CPBIN}/${PROJECT_ID}/raw_images/
export OUTPUT_DATA=${CPBIN}/${PROJECT_ID}/output_data
export PROJECT_TITLE=$(echo ${PROJECT_ID} | cut -f2 -d "/")
export SUMMARY_DATA=${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data


echo "
########################################
## Non-Overlapping Data Concatenation ##
########################################
"

# CONTROL MODEL OUTPUTS
cd ${SUMMARY_DATA}/NonOverlappingWorms_Data
files=(*_control.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_control1.csv
tail -n +2 -q *_control.csv > ${PROJECT_TITLE}_all_control2.csv
cat ${PROJECT_TITLE}_all_control1.csv ${PROJECT_TITLE}_all_control2.csv > ${PROJECT_TITLE}_all_control.csv
rm *NonOverlappingWorms_control.csv
rm ${PROJECT_TITLE}_all_control1.csv
rm ${PROJECT_TITLE}_all_control2.csv

# FULL MODEL OUTPUTS
files=(*_full.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_full1.csv
tail -n +2 -q *_full.csv > ${PROJECT_TITLE}_all_full2.csv
cat ${PROJECT_TITLE}_all_full1.csv ${PROJECT_TITLE}_all_full2.csv > ${PROJECT_TITLE}_all_full.csv
rm *NonOverlappingWorms_full.csv
rm ${PROJECT_TITLE}_all_full1.csv
rm ${PROJECT_TITLE}_all_full2.csv

# HIGH MODEL OUTPUTS
files=(*_high.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_high1.csv
tail -n +2 -q *_high.csv > ${PROJECT_TITLE}_all_high2.csv
cat ${PROJECT_TITLE}_all_high1.csv ${PROJECT_TITLE}_all_high2.csv > ${PROJECT_TITLE}_all_high.csv
rm *NonOverlappingWorms_high.csv
rm ${PROJECT_TITLE}_all_high1.csv
rm ${PROJECT_TITLE}_all_high2.csv



echo "
####################################
## Overlapping Data Concatenation ##
####################################
"

# CONTROL MODEL OUTPUTS
cd ${SUMMARY_DATA}/OverlappingWorms_Data
files=(*_control.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_control1.csv
tail -n +2 -q *_control.csv > ${PROJECT_TITLE}_all_control2.csv
cat ${PROJECT_TITLE}_all_control1.csv ${PROJECT_TITLE}_all_control2.csv > ${PROJECT_TITLE}_all_control.csv
rm *OverlappingWorms_control.csv
rm ${PROJECT_TITLE}_all_control1.csv
rm ${PROJECT_TITLE}_all_control2.csv

# FULL MODEL OUTPUTS
files=(*_full.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_full1.csv
tail -n +2 -q *_full.csv > ${PROJECT_TITLE}_all_full2.csv
cat ${PROJECT_TITLE}_all_full1.csv ${PROJECT_TITLE}_all_full2.csv > ${PROJECT_TITLE}_all_full.csv
rm *OverlappingWorms_full.csv
rm ${PROJECT_TITLE}_all_full1.csv
rm ${PROJECT_TITLE}_all_full2.csv

# HIGH MODEL OUTPUTS
files=(*_high.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_high1.csv
tail -n +2 -q *_high.csv > ${PROJECT_TITLE}_all_high2.csv
cat ${PROJECT_TITLE}_all_high1.csv ${PROJECT_TITLE}_all_high2.csv > ${PROJECT_TITLE}_all_high.csv
rm *OverlappingWorms_high.csv
rm ${PROJECT_TITLE}_all_high1.csv
rm ${PROJECT_TITLE}_all_high2.csv
