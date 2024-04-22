# Gene-Symbol-and-Biotypes-Converter
This repositiory contains R code for the analysis of gene expression data obtained from RNA-seq experiments. The code leverages the biomaRt package to 
translate Entrez IDs into gene symbols and biotypes for genes that are either upregulated or downregulated. The primary script imports Entrez IDs 
from CSV files, establishes a connection with the Ensembl BioMart database, and retrieves the corresponding gene symbols and biotypes. 
The outcomes are then saved in distinct CSV files for the upregulated and downregulated genes. This tool facilitates the transformation of 
Entrez IDs into gene symbols and biotypes, enabling further analysis and interpretation of gene expression data.
