#!/usr/bin/env nextflow

process FASTQC {
    label 'process_medium'
    container 'ghcr.io/bf528/fastqc:latest'
    publishDir "${params.outdir}/fastqc", mode: "copy"
    
    input:
    tuple val(sample_id), path(reads)

    output:
    path("${reads.simpleName}_fastqc.html"), emit: html
    path("${reads.simpleName}_fastqc.zip"), emit: zip
    
    script:
    """
    fastqc -t $task.cpus $reads
    """

    stub:
    """
    touch ${reads.simpleName}_fastqc.html
    touch ${reads.simpleName}_fastqc.zip
    """
}


