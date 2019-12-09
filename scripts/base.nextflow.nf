#! usr/bin/env nextflow

# I want the command to run like this:
# nextflow run cell.profiler.nf --projectpath ~/path/to/project_directory

/ *
** USER INPUT PARAMETERS
* /

params.projectpath = null
params.cellprofilerbin = "/projects/b1059/software/CellProfiler"

images.ch = Channel.fromPath('params.projectpath')

/*
process establishPaths {
  input:
        
  output:

  """

  """
}
* /


/*
process executeCellProfiler {
  input:

  output:

  """

  """
  }
* /



/ *
process concatenateOutputData {
  input:

  output:

  """

  """
  }
* /
