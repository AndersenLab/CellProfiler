#!/usr/bin/env nextflow

// srun -A b1042 --partition=genomicsguestA -N 1 -n 2 --mem=16G --time=48:00:00 --pty bash -i
params.CPBIN = file("/projects/b1059/software/CellProfiler")
params.imagedir = file("${params.CPBIN}/projects/20190926_drugresponse/raw_images")
params.metadata = null

println "NF Project : $workflow.projectDir"
println "Work : $workflow.workDir"
println "Home : $workflow.homeDir"
println "Project Image Directory : $params.imagedir"




/*
Create Image Channel
*/
Channel
  .fromPath( "${params.imagedir}/*.TIF" )
  .into{ images1; images2 }




/*
Create Metadata Channel
*/
Channel
  .fromPath( "${params.metadata}" )
  .into{ metadata1; metadata2 }




/*
Create Run Logs: Images, Metadata
*/
process PublishLogs {

  publishDir "${params.CPBIN}/run.logs", mode: 'copy'

  input:
  file images from images1.collect()
  file metadata from metadata1

  output:
  file("cp.image.log.txt")
  file("cp.metadata.log.txt")

  """
  ls ${images} | cat > cp.image.log.txt
  ls ${metadata} | cat > cp.metadata.log.txt
  """

}


/*

"""
NINDICES=$(less ${params.metadata} | tail -n+2 | wc -l)
seq 1 ${NINDICES} > cp.indices.txt | echo
"""
*/

/*
process PrintImages {

    publishDir

    input:
    file image from images

    output:
    stdout result

    """
    echo "Beginning analysis: $image"
    """
}
result.view { it }
*/
