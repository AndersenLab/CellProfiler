// Script parameters
//


params.projectpath = "images/raw_images/20190926_drugresponse/"
params.cellprofilerbin = ""


// process establishPaths {
  }
// process executeCellProfiler {
  }
// process concatenateOutputData {
  }

process blastSearch {
    input:
    file query from query_ch

    output:
    file "top_hits.txt" into top_hits_ch

    """
    blastp -db $db -query $query -outfmt 6 > blast_result
    cat blast_result | head -n 10 | cut -f 2 > top_hits.txt
    """
}

process extractTopHits {
    input:
    file top_hits from top_hits_ch

    output:
    file "sequences.txt" into sequences_ch

    """
    blastdbcmd -db $db -entry_batch $top_hits > sequences.txt
    """
}
