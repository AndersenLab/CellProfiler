#!/usr/bin/env nextflow

params.projectdir = file("${HOME}/projects/20190926_drugresponse/raw_images/*.TIF")

println "Project : $workflow.projectDir"
println "Work : $workflow.workDir"
println "Home : $workflow.homeDir"

process identifyImages {

    output:
    stdout result

    """
    echo ${params.projectdir}
    """
}
result.view { it }
