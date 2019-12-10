#!/usr/bin/env nextflow

params.projectdir = '/projects/20190926_drugresponse'

process identifyImages {

    input:
    path x from params.projectdir

    output:
    stdout result

    """
    cd '$x/raw_images/'
    ls -l
    """
}
result.view { it }
