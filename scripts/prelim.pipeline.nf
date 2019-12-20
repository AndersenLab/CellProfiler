#!/usr/bin/env nextflow

// srun -A b1059 --partition=genomicsguestA -N 1 -n 2 --mem=16G --time=48:00:00 --pty bash -i
params.CPBIN = file("/projects/b1059/software/CellProfiler")
params.imagedir = file("${params.CPBIN}/projects/20190926_drugresponse")

println "NF Project : $workflow.projectDir"
println "Work : $workflow.workDir"
println "Home : $workflow.homeDir"
println "Project Image Directory : $params.imagedir"

Channel
  .fromPath( "${params.imagedir}/raw_images/*.TIF" )
  .view()
  .size()


/*
process identifyImages {

    input:
    file image from images

    output:
    stdout result

    """
    echo "Beginning analysis: $image"
    """
}
result.view { it }
*/
