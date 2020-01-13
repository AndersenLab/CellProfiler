# Andersen Lab Image Analysis Pipeline
## Implemented using CellProfiler


### To recreate CellProfiler (CP) on QUEST:
1) Navigate to shared allocation:
```
ssh -X user@quest.it.northwestern.edu
cd ../../projects/b1059/software
```
2) Clone CP repository
```
git clone git@github.com/AndersenLab/CellProfiler.git
```
3) Download CP Docker image and convert to Singularity image within CP directory:
```
cd CellProfiler
module load singularity
singularity pull docker://cellprofiler/cellprofiler:3.1.9
```
