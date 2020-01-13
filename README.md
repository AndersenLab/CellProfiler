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


### CellProfiler Directory Structure (With Example Files)

```
CellProfiler
  ├── batch_files
      ├── dose_response.h5
      ├── growth_batch.h5
  ├── metadata
      ├── 20190926_drugresponse_metadata.csv
      ├── 20191119_growth_metadata.csv
  ├── pipelines
      ├── 20200113_CP3_batchfilecreation.cpproj
      ├── cp.3_SJW_gitenabled_20191213.cpproj
  ├── projects
      ├── 20190926_drugresponse
        ├── raw_images
      ├── 20191119_growth
        ├── raw_images
        ├── output_data
            ├── 20191119_growth_summary_data
                ├── Logs
                ├── ProcessedImages
                ├── OverlappingWorms_Data
                ├── NonOverlappingWorms_Data
  ├── scripts
      ├── cellprofiler.SW.20200113.sh
      ├── cellprofiler.JN.20200113.sh
      ├── concatenate.quadpipeline.results.JN.sh
      ├── run.cell.profiler.20200113.sh
      ├── concatenate.triplepipeline.results.sh
  ├── well_masks
      ├── wellmask_98.png
  ├── worm_models
      ├── Adult_N2_HB101_50w.xml
      ├── L1_N2_HB101_50w.xml
      ├── L2L3_N2_HB101_50w.xml
      ├── L4_N2_HB101_50w.xml
      ├── WM_FBZ_control.xml
      ├── WM_FBZ_dose.xml
      ├── high_dose_worm_model.xml
```
