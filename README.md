## Recreation of RNA-seq/Differential Expression Analysis from "The type 1 diabetes gene TYK2 regulates β-cell development and its responses to interferon-α" Chandra et al., 2022.

## Data Source
This project uses paired-end RNA-seq reads from Chandra et al. (2022), which investigates the role of the type 1 diabetes gene, TYK2, in β-cell development and response to IFNα.

**Data:** RNA-seq data from NCBI GEO, accession code: GSE190727 and GSE190725.


## Running the Pipeline
```bash
nextflow run main.nf -profile singularity,cluster
```

## Citation
Chandra, V., Ibrahim, H., Halliez, C. et al. The type 1 diabetes gene TYK2 regulates β-cell development and its responses to interferon-α. Nat Commun 13, 6363 (2022). https://doi.org/10.1038/s41467-022-34069-z