#!/usr/bin/env nextflow

// Including the tools from module here:
include {FASTQC} from './modules/fastqc'
include {PARSE_GTF} from './modules/parse_gtf'
include {INDEX} from './modules/star'
include {ALIGN} from './modules/star_align'
include {MULTIQC} from './modules/multiqc'
include {VERSE} from './modules/verse'
include {CONCAT} from './modules/concat'


workflow {

    // Create the channels/tuples that will hold the information to pass through pipeline
    Channel.fromFilePairs(params.reads)
        .transpose()
    | set{ fastqc_channel }

    Channel.fromFilePairs(params.reads)
    | set{ align_ch }
       
    // Read the GTF file and creates a delimited file of ensembl human ID and gene name
    PARSE_GTF(params.gtf)

    // Perform QC on each of the reads
    FASTQC(fastqc_channel) 
    
    // Generate Genome Index of the Human Genome with STAR Aligner
    INDEX(params.genome, params.gtf) 
    
    // Align experimentally obtained paired-end reads with Genome Index with STAR Aligner
    ALIGN(align_ch, INDEX.out.index)
   
   // Collect every FASTQC file to pass through MULTIQC
    FASTQC.out.zip
        .collect()
    | set { fastqc_out }
    
    // Collect all aligned files with the FASTQC files to pass through MULTIQC
    ALIGN.out.log
        .mix(fastqc_out)
        .flatten()
        .collect()
    | set { multiqc_channel }
     
    // Run MULTIQC on FASTQC and the STAR aligned reads 
    MULTIQC(multiqc_channel)

    // Generate gene-level counts for each sample 
        // For this pipeline: We will generate a single count for every gene representing the sum 
        // of the union of all alignments falling into every exon annotated to that gene. 
        // This gene-level count will be used as a proxy for that gene’s expression in a particular sample.
    VERSE(params.gtf, ALIGN.out.bam)

    // Collect the gene-level counts from each sample and put into a channel
    VERSE.out.counts
        .collect()
    | set{ concat_ch }

    // Concatenate the gene-level counts into a single counts matrix
    CONCAT(concat_ch)

}
