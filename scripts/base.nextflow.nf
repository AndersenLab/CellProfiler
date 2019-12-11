#!/usr/bin/env nextflow

params.imagedir = "null"
// params.projectdir = file("${HOME}/projects/20190926_drugresponse/raw_images/*.TIF")

println "Project : $workflow.projectDir"
println "Work : $workflow.workDir"
println "Home : $workflow.homeDir"

myImageChannel = Channel.fromPath( "${HOME}/${params.imagedir}/raw_images/*.TIF" )
myImageChannel.subscribe { println "image: $it" }


/*
process identifyImages {

    output:
    stdout result

    """
    echo ${params.projectdir}
    """
}
result.view { it }
*/
