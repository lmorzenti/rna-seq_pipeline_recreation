## Recreation of RNA-seq/Differential Expression Analysis from "The type 1 diabetes gene TYK2 regulates β-cell development and its responses to interferon-α" Chandra et al., 2022.

## Data Source
This project uses paired-end RNA-seq reads generated from Chandra et al. (2022), which investigates the role of the type 1 diabetes gene, TYK2, in β-cell development and response to IFNα. The analysis uses DESeq2 to complete differential expression analysis.

**Data**: RNA-seq data from NCBI GEO, accession code: GSE190727 and GSE190725.


## Running the Pipeline
Prerequisites: Ensure that you have nextflow(v25.04.6) installed and ready to use on your system.

Clone this repository 
``` bash 
git clone <ssh>
cd <this-project-directory>
``` 

Running this pipeline
``` bash
nextflow run main.nf -profile singularity,cluster
```

This pipeline assumes that you are passing the paired end reads in files that are in a .fastq.gz form. The pipeline will take these files to send through preprocessing and quality control. It will generate a single matrix in a csv file that consists of gene-level counts. This file can then be passed through DESeq2 to complete differential gene expression analysis.


## Citation
1. Chandra, V., Ibrahim, H., Halliez, C. et al. The type 1 diabetes gene TYK2 regulates β-cell development and its responses to interferon-α. Nat Commun 13, 6363 (2022). https://doi.org/10.1038/s41467-022-34069-z