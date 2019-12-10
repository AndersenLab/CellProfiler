#!/usr/bin/env nextflow

params.projectdir = 'projects/20190926_drugresponse'

process identifyImages {

    output:
    stdout result

    """
    ls '${params.projectdir}'
    """
}
result.view { it }
