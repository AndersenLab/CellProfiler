#!/usr/bin/env nextflow

params.imagedir = file("${HOME}/projects/20190926_drugresponse/")
// params.projectdir = file("${HOME}/projects/20190926_drugresponse/raw_images/*.TIF")

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
