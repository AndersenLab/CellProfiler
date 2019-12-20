#!/usr/bin/env nextflow

params.CPBIN = file("/projects/b1059/software/CellProfiler")
params.imagedir = file("")

println "NF Project : $workflow.projectDir"
println "Work : $workflow.workDir"
println "Home : $workflow.homeDir"
println "Project Image Directory : $params.imagedir"

myImageChannel = Channel.fromPath( "${params.imagedir}/raw_images/*.TIF" )
process identifyImages {

    input:
    file image from myImageChannel

    output:
    stdout result

    """
    echo "Beginning analysis: $image"
    """
}
result.view { it }
