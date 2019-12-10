#!/usr/bin/env nextflow

params.projectdir = '/projects/20190926_drugresponse'

process identifyImages {

    input:
    path x from params.projectdir

    output:
    stdout result

    """
    ls $x/raw_images
    """
}
result.view { it }
