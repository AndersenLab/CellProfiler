#!/usr/bin/env nextflow

params.projectdir = 'projects/20190926_drugresponse'
myImageChannel = Channel.fromPath( '${HOME}/params.projectdir/raw_images/*.TIF' )

process identifyImages {

    input:
    image x from myImageChannel

    output:
    stdout result

    """
    echo '$x'
    """
}
result.view { it }
