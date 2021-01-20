### Preparing Files for Genetic Correlation Analysis Using LDSC ######

### Step One: Read in File ######

sumstats <- read.delim("[Enter File Path Here]", header = TRUE)

### Step Two: Check Header Names ######

col.names(sumstats)

# Taken from https://github.com/bulik/ldsc/wiki/Summary-Statistics-File-Format
# Required Columns, and best names 
# SNP -- SNP identifier (e.g., rs number)
# N -- sample size (which may vary from SNP to SNP).
# Beta -- z-score. Sign with respect to A1 (warning, possible gotcha)
# A1 -- first allele (effect allele)
# A2-- second allele (other allele)
# P -- P Value 

### Step Three: Drop Unnecessary Columns ######

sumstats <- sumstats[-c([Enter Columns to Drop Here])]

### Step Four: Rename Columns ######

library(tidyverse)

sumstats <- sumstats %>%
    rename(
        SNP = [Old Name]
        N = [Old Name]
        Beta = [Old Name]
        A1 = [Old Name]
        A2 = [Old Name]
        P = [Old Name]
    )

### Step Five: Output File as .txt file ######

write.table(sumstats, "[File Name].txt", col.names = TRUE, row.names = FALSE, sep = " ")