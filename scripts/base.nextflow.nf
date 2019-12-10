#!/usr/bin/env nextflow

params.projectdir = 'projects/20190926_drugresponse'

process identifyImages {

    input:

    output:
    stdout result

    """
    echo '${params.projectdir}'
    """
}
result.view { it }
