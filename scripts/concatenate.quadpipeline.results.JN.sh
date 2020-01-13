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

# L1 MODEL OUTPUTS
cd ${SUMMARY_DATA}/NonOverlappingWorms_Data
files=(*L1_NonOverlappingWorms.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_L1_1.csv
tail -n +2 -q *L1_NonOverlappingWorms.csv > ${PROJECT_TITLE}_all_L1_2.csv
cat ${PROJECT_TITLE}_all_L1_1.csv ${PROJECT_TITLE}_all_L1_2.csv > ${PROJECT_TITLE}_all_L1.csv
rm *L1_NonOverlappingWorms.csv
rm ${PROJECT_TITLE}_all_L1_1.csv
rm ${PROJECT_TITLE}_all_L1_2.csv

# L2/L3 MODEL OUTPUTS
files=(*L2L3_NonOverlappingWorms.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_L2L3_1.csv
tail -n +2 -q *L2L3_NonOverlappingWorms.csv > ${PROJECT_TITLE}_all_L2L3_2.csv
cat ${PROJECT_TITLE}_all_L2L3_1.csv ${PROJECT_TITLE}_all_L2L3_2.csv > ${PROJECT_TITLE}_all_L2L3.csv
rm *L2L3_NonOverlappingWorms.csv
rm ${PROJECT_TITLE}_all_L2L3_1.csv
rm ${PROJECT_TITLE}_all_L2L3_2.csv

# L4 MODEL OUTPUTS
files=(*L4_NonOverlappingWorms.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_L4_1.csv
tail -n +2 -q *L4_NonOverlappingWorms.csv > ${PROJECT_TITLE}_all_L4_2.csv
cat ${PROJECT_TITLE}_all_L4_1.csv ${PROJECT_TITLE}_all_L4_2.csv > ${PROJECT_TITLE}_all_L4.csv
rm *L4_NonOverlappingWorms.csv
rm ${PROJECT_TITLE}_all_L4_1.csv
rm ${PROJECT_TITLE}_all_L4_2.csv

# HIGH MODEL OUTPUTS
files=(*adult_NonOverlappingWorms.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_adult_1.csv
tail -n +2 -q *adult_NonOverlappingWorms.csv > ${PROJECT_TITLE}_all_adult_2.csv
cat ${PROJECT_TITLE}_all_adult_1.csv ${PROJECT_TITLE}_all_adult_2.csv > ${PROJECT_TITLE}_all_adult.csv
rm *adult_NonOverlappingWorms.csv
rm ${PROJECT_TITLE}_all_adult_1.csv
rm ${PROJECT_TITLE}_all_adult_2.csv

echo "
####################################
## Overlapping Data Concatenation ##
####################################
"

# L1 MODEL OUTPUTS
cd ${SUMMARY_DATA}/OverlappingWorms_Data
files=(*L1_OverlappingWorms.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_L1_1.csv
tail -n +2 -q *L1_OverlappingWorms.csv > ${PROJECT_TITLE}_all_L1_2.csv
cat ${PROJECT_TITLE}_all_L1_1.csv ${PROJECT_TITLE}_all_L1_2.csv > ${PROJECT_TITLE}_all_L1.csv
rm *L1_OverlappingWorms.csv
rm ${PROJECT_TITLE}_all_L1_1.csv
rm ${PROJECT_TITLE}_all_L1_2.csv

# L2/L3 MODEL OUTPUTS
files=(*L2L3_OverlappingWorms.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_L2L3_1.csv
tail -n +2 -q *L2L3_OverlappingWorms.csv > ${PROJECT_TITLE}_all_L2L3_2.csv
cat ${PROJECT_TITLE}_all_L2L3_1.csv ${PROJECT_TITLE}_all_L2L3_2.csv > ${PROJECT_TITLE}_all_L2L3.csv
rm *L2L3_OverlappingWorms.csv
rm ${PROJECT_TITLE}_all_L2L3_1.csv
rm ${PROJECT_TITLE}_all_L2L3_2.csv

# L4 MODEL OUTPUTS
files=(*L4_OverlappingWorms.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_L4_1.csv
tail -n +2 -q *L4_OverlappingWorms.csv > ${PROJECT_TITLE}_all_L4_2.csv
cat ${PROJECT_TITLE}_all_L4_1.csv ${PROJECT_TITLE}_all_L4_2.csv > ${PROJECT_TITLE}_all_L4.csv
rm *L4_OverlappingWorms.csv
rm ${PROJECT_TITLE}_all_L4_1.csv
rm ${PROJECT_TITLE}_all_L4_2.csv

# HIGH MODEL OUTPUTS
files=(*adult_OverlappingWorms.csv)
less ${files[RANDOM % ${#files[@]}]} | head -1 > ${PROJECT_TITLE}_all_adult_1.csv
tail -n +2 -q *adult_OverlappingWorms.csv > ${PROJECT_TITLE}_all_adult_2.csv
cat ${PROJECT_TITLE}_all_adult_1.csv ${PROJECT_TITLE}_all_adult_2.csv > ${PROJECT_TITLE}_all_adult.csv
rm *adult_OverlappingWorms.csv
rm ${PROJECT_TITLE}_all_adult_1.csv
rm ${PROJECT_TITLE}_all_adult_2.csv
