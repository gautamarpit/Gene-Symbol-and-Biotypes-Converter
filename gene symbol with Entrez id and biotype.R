# Install and load the biomaRt package
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("biomaRt")
library(biomaRt)

# Connect to the appropriate BioMart database
mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")

# Define function to convert Entrez IDs to gene symbols and biotypes
convert_entrezid_to_symbol_biotypes <- function(entrez_ids, mart) {
  genes <- getBM(attributes = c("entrezgene_id", "external_gene_name", "gene_biotype"), 
                 filters = "entrezgene_id",
                 values = entrez_ids,
                 mart = mart)
  return(genes)
}

# Read Entrez IDs from a CSV file for upregulated genes (assuming Entrez IDs are in the first column)
upreg_entrez_id_file <- "upreg.csv"  # Replace with the name of your CSV file containing upregulated Entrez IDs
upreg_entrez_data <- read.csv(upreg_entrez_id_file, header = TRUE, stringsAsFactors = FALSE)

# Extract upregulated Entrez IDs from the data frame
upreg_entrez_ids <- upreg_entrez_data$entrez_id

# Convert upregulated Entrez IDs to gene symbols and biotypes
upreg_gene_symbols_biotypes <- convert_entrezid_to_symbol_biotypes(upreg_entrez_ids, mart)

# Add Entrez ID column to the data frame if the number of rows match
if (nrow(upreg_entrez_data) == nrow(upreg_gene_symbols_biotypes)) {
  upreg_gene_symbols_biotypes <- cbind(Entrez_ID = upreg_entrez_ids, upreg_gene_symbols_biotypes)
} else {
  # Print a warning if the number of rows does not match
  warning("Number of rows in upregulated Entrez IDs and gene symbols/biotypes does not match. Entrez IDs may be missing.")
}

# Write upregulated gene symbols and biotypes to a CSV file
upreg_output_file <- "upreg_symbol_biotypes.csv"  # Output CSV file name for upregulated genes
write.csv(upreg_gene_symbols_biotypes, file = upreg_output_file, row.names = FALSE)

# Read Entrez IDs from a CSV file for downregulated genes (assuming Entrez IDs are in the first column)
downreg_entrez_id_file <- "downreg.csv"  # Replace with the name of your CSV file containing downregulated Entrez IDs
downreg_entrez_data <- read.csv(downreg_entrez_id_file, header = TRUE, stringsAsFactors = FALSE)

# Extract downregulated Entrez IDs from the data frame
downreg_entrez_ids <- downreg_entrez_data$entrez_id

# Convert downregulated Entrez IDs to gene symbols and biotypes
downreg_gene_symbols_biotypes <- convert_entrezid_to_symbol_biotypes(downreg_entrez_ids, mart)

# Add Entrez ID column to the data frame if the number of rows match
if (nrow(downreg_entrez_data) == nrow(downreg_gene_symbols_biotypes)) {
  downreg_gene_symbols_biotypes <- cbind(Entrez_ID = downreg_entrez_ids, downreg_gene_symbols_biotypes)
} else {
  # Print a warning if the number of rows does not match
  warning("Number of rows in downregulated Entrez IDs and gene symbols/biotypes does not match. Entrez IDs may be missing.")
}

# Write downregulated gene symbols and biotypes to a CSV file
downreg_output_file <- "downreg_symbol_biotypes.csv"  # Output CSV file name for downregulated genes
write.csv(downreg_gene_symbols_biotypes, file = downreg_output_file, row.names = FALSE)

# Print message indicating successful completion
cat("Gene symbols and biotypes with Entrez IDs for upregulated genes written to:", upreg_output_file, "\n")
cat("Gene symbols and biotypes with Entrez IDs for downregulated genes written to:", downreg_output_file, "\n")

