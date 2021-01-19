### Manhattan Plot, QQplot and GC Inflation Factor Caclulation ######

### Step One: Load File(s) and assign name GWAS ######

GWAS <- read.delim([Enter File Path], header = TRUE)

### Step Two: Load Packages ######

library(tidyverse)
library(ggman)
library(ggQQunif)

### Step Three: Check Column Names of input file ######

colnames(GWAS)

### Step Four: Amend script / names if necessary ######

### Manhattan Plot ######

# In GWAS Manhattan plots, genomic coordinates are displayed along the X-axis,
# with the negative logarithm of the association p-value for each SNP 
# displayed on the Y-axis, meaning that each dot on the Manhattan plot signifies a SNP. 
# Because the strongest associations have the smallest p-values (e.g., 10−15), their negative logarithms 
# will be the greatest (e.g., 15). The different colors of each block usually shows the extent of each chromosome

manhattan <- ggman(GWAS, snp = "SNP", bp = "BP", chrom = "CHR", pvalue = "P", relative.positions = TRUE, lineColour = "black", xlabel = "Chromosome", ylabel = "-Log10 P Value", title = "[Title Name Here]")

### Do NOT try and load it, plot straight to PNG ######
png(filename="ManhattanPlot.png",type="cairo",width=4800,height=3200,pointsize=4,res=300)
print(manhattan)
dev.off()

### QQ Plot ######

# Genome-wide analysis involves hundreds of thousands of statistical tests, 
# and even modest levels of bias can distort the null distribution and overwhelm 
# a small number of true associations. To search for evidence of systematic bias 
# (from unrecognized population structure, analytical approach, genotyping artifacts, etc.), 
# a quantile-quantile (Q-Q) plot can be used to characterize the extent to which the observed 
# distribution of the test statistic follows the expected (null) distribution

qqplot <- GWAS %>%
  ggplot(mapping = aes(sample = P)) +
  geom_QQ_unif() +
  scale_x_QQ() + 
  scale_y_QQ() + 
  theme_minimal() +
  geom_abline(intercept = 0, slope =1)

### GC Inlfation Factor ######

# The genomic inflation factor \( \lambda \) is defined as the ratio of the median of the 
# empirically observed distribution of the test statistic to the expected median, thus quantifying 
# the extent of the bulk inflation and the excess false positive rate

chisq <- qchisq(1-GWAS$P,1)
lambda <- median(chisq)/qchisq(0.5,1)
