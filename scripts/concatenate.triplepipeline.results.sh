#!/bin/bash

export CPBIN=/projects/b1059/software/CellProfiler
export PROJECT_ID=$1
export IMAGES=${CPBIN}/${PROJECT_ID}/raw_images/
export OUTPUT_DATA=${CPBIN}/${PROJECT_ID}/output_data
export PROJECT_TITLE=$(echo ${PROJECT_ID} | cut -f2 -d "/")

# CONTROL MODEL OUTPUTS
ls ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data/*control.csv > control.list.txt
files=(${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data/*_control.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_control1.csv
tail -n +2 -q ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data/*_control.csv > ${PROJECT_TITLE}_all_control2.csv
cat ${PROJECT_TITLE}_all_control1.csv ${PROJECT_TITLE}_all_control2.csv > ${PROJECT_TITLE}_all_control.csv
rm ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/*NonOverlappingWorms_control.csv
rm ${OUTPUT_DATA}/${PROJECT_TITLE}_all_control1.csv
rm ${OUTPUT_DATA}/${PROJECT_TITLE}_all_control2.csv

# FULL MODEL OUTPUTS
ls ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data/*full.csv > full.list.txt
files=(${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data/*_full.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_full1.csv
tail -n +2 -q ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data/*_full.csv > ${PROJECT_TITLE}_all_full2.csv
cat ${PROJECT_TITLE}_all_full1.csv ${PROJECT_TITLE}_all_full2.csv > ${PROJECT_TITLE}_all_full.csv
rm ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/*NonOverlappingWorms_control.csv
rm ${OUTPUT_DATA}/${PROJECT_TITLE}_all_control1.csv
rm ${OUTPUT_DATA}/${PROJECT_TITLE}_all_control2.csv

# HIGH MODEL OUTPUTS
ls ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data/*high.csv > high.list.txt
files=(${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data/*_high.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_high1.csv
tail -n +2 -q ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/NonOverlappingWorms_Data/*_high.csv > ${PROJECT_TITLE}_all_high2.csv
cat ${PROJECT_TITLE}_all_high1.csv ${PROJECT_TITLE}_all_high2.csv > ${PROJECT_TITLE}_all_high.csv
rm ${OUTPUT_DATA}/${PROJECT_TITLE}_summary_data/*NonOverlappingWorms_control.csv
rm ${OUTPUT_DATA}/${PROJECT_TITLE}_all_control1.csv
rm ${OUTPUT_DATA}/${PROJECT_TITLE}_all_control2.csv
