#!/usr/bin/env nextflow

params.projectdir = 'projects/20190926_drugresponse'

process identifyImages {

    input:

    output:
    stdout result

    """
    ls '${params.projectdir}/raw_images'
    """
}
result.view { it }
