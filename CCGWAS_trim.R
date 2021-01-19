### Preparing CCGWAS Raw Data for Analysis ######

### Step One: Load Packages ######
library(data.table)
library(R.utils)

### Step Three: Trim ######
d <- as.data.frame(fread("[Enter CCGWAS Results File Name Here]",header=TRUE))
d <- d[ {d$OLS_pval<5e-8 & d$CCGWAS_signif==0}==FALSE ,] ## step (i)
d <- d[,c("SNP","CHR","BP","EA","NEA","OLS_beta","OLS_se","OLS_pval","Exact_beta","Exact_se","Exact_pval","CCGWAS_signif")] ## step (ii): reduces number of columns from 23 to 12
fwrite(d,file="[Enter CCGWAS Trimmed Results File Name Here]",col.names=TRUE,na="NA" ,row.names=FALSE,quote=FALSE,sep="\t")



