#!/bin/bash

# To run:
# bash scripts/run.cell.profiler.sh images/raw_images/20190926_drugresponse/

export PROJECT_ID=$1
NIMAGES=$(ls ${PROJECT_ID}/ | wc -l)

COUNT=1; \
for i in $(seq $NIMAGES); \
  do sbatch scripts/cellprofiler.20191121.sh $i;\
  let COUNT=$COUNT+1; \
done
