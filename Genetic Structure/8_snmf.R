###############################################
#### SNMF script for population structure. ####
######### Uranoscodon superciliosus ###########
###############################################

###############################################
############## Manuela Santos #################
##############      2024      #################
###### adaptado de Script Romina Pithecia #####
##############################################

#installing all necessary packages

#install.packages("devtools")
#install.packages("remotes")
#install.packages("BiocManager")
#devtools::install_github("bcm-uga/LEA")
#install.packages("vegan")
#devtools::install_github("bcm-uga/lfmm")
#BiocManager::install("qvalue")

##I. REMOVE ANY OBJECT OR FUNCTION IN THE ENVIRONMENT ----
rm(list=ls())

# Shell 1st: removing files, when necessary

#conda activate agar22

#vcftools --remove rem_outgroupetrupico_e_pitpit --vcf REF01_ML_map.vcf --recode --out Pithecia_west_filtered_snps.vcf

#comando 2024 MVS


getwd()
list.files()
# "/Users/xsmanu/Library/CloudStorage/GoogleDrive-manuelasantos237@gmail.com/Meu Drive/Manuela_Trabalhos/MPEG/2021_Doutorado_PPGBE/University of Gothemburg/Analysis/sNMF"

# Load the packages
  
library("adegenet")
library("LEA")
library("vcfR")


#input <- read.vcfR("Neutral.vcf")

#vcf2geno("file.vcf", "file.geno")

#Alternative ways to convert files by Dalapicolla et al., 2023
#Rstudio is crashing when running vcf2geno command, with my datasets obtained in R after flexible filtering

###1. CONVERT FILES IN R ----
#A. Load VCF in R
vcf = read.vcfR("file.vcf")
#check file
vcf

#B. Convert VCF to Genotypes
genotypes= t(extract.gt(vcf, element = "GT", mask = FALSE, as.numeric = TRUE, return.alleles = FALSE, IDtoRowNames = TRUE, extract = TRUE, convertNA = TRUE))
#check:
genotypes[1:5,1:5]
row.names(genotypes)

#C. Convert Genotypes to LFMM:
dim(genotypes)
((sum(is.na(genotypes)))/(dim(genotypes)[1]*dim(genotypes)[2]))*100
#22.02%  #Amount of missing data

genotypes[is.na(genotypes)] <- 9 #The missing genotypes have to be encoded with the value 9
genotypes[1:10,1:10]
write.lfmm(genotypes,"file.lfmm")


lfmm_input = read.lfmm("file.lfmm")
geno_input = lfmm2geno("file.lfmm", output.file = "file.geno", force = TRUE)



#alfa1
alfa1 = snmf("file.geno", K = 1:10, ploidy = 2, entropy = T, alpha = 1, project = "new", iteration = 2000, repetition = 10, seed = 10, CPU = 4)

#alfa10
alfa10 = snmf("file.geno", K = 1:10, ploidy = 2, entropy = T, alpha = 10, project = "new", iteration = 2000, repetition = 10, seed = 10, CPU = 4)

#alfa100
alfa100 = snmf("file.geno", K = 1:10, ploidy = 2, entropy = T, alpha = 100, project = "new", iteration = 2000, repetition = 10, seed = 10, CPU = 4)

#alfa1000 
alfa1000 = snmf("file.geno", K = 1:10, ploidy = 2, entropy = T, alpha = 1000, project = "new", iteration = 2000, repetition = 10, seed = 10, CPU = 4)

#plotar o cross-entropy para cada K. Selecionar o com menor entropia ou onde a curva estabiliza

plot(alfa1, col = "blue4", cex = 1.4, pch = 19)
plot(alfa10, col = "blue4", cex = 1.4, pch = 19)
plot(alfa100, col = "blue4", cex = 1.4, pch = 19)
plot(alfa1000, col = "blue4", cex = 1.4, pch = 19)


#Best for this run K=5 
#2 melhor K=6

# Veja a melhor corrida para K= 2 
best.a1 = cross.entropy(alfa1, K = 2)

best.a1

#K = 5
#run 1  0.2213348
#run 2  0.2235175
#run 3  0.2197417
#run 4  0.2217201
#run 5  0.2221456
#run 6  0.2236757
#run 7  0.2244558
#run 8  0.2256481
#run 9  0.2217489
#run 10 0.2216048

min(best.a1)
#0.2197417

best.a10 = cross.entropy(alfa10, K = 2)

best.a10

#K = 5
#run 1  0.2213543
#run 2  0.2235231
#run 3  0.2197385
#run 4  0.2217204
#run 5  0.2221441
#run 6  0.2236764
#run 7  0.2244584
#run 8  0.2256505
#run 9  0.2216926
#run 10 0.2216024

min(best.a10)
#0.2197385

best.a100 = cross.entropy(alfa100, K = 2)
best.a100

#K = 5
#run 1  0.2213222
#run 2  0.2235942
#run 3  0.2197138
#run 4  0.2217119
#run 5  0.2221390
#run 6  0.2236809
#run 7  0.2245095
#run 8  0.2257028
#run 9  0.2217168
#run 10 0.2215870

min(best.a100)
#0.2197138

best.a1000 = cross.entropy(alfa1000, K = 2)
best.a1000

#K = 5
#run 1  0.2214309
#run 2  0.2243531
#run 3  0.2199688
#run 4  0.2219269
#run 5  0.2223499
#run 6  0.2241650
#run 7  0.2249379
#run 8  0.2265240
#run 9  0.2219214
#run 10 0.2217389

min(best.a1000)
#0.2199688

bestrun<-min(best.a1,best.a10,best.a100);bestrun
#0.2197138 a100

#plot(best.a1)
plot(best.a100)

# select the run with the lowest cross-entropy
bestrun_alfa1 = which.min(best.a1)
bestrun_alfa1 #3

bestrun_alfa10 = which.min(best.a10)
bestrun_alfa10 #3

bestrun_alfa100 = which.min(best.a100)
bestrun_alfa100 #3

bestrun_alfa1000 = which.min(best.a1000)
bestrun_alfa1000 #10

#Gerar o Qplot
qmatrix_alfa1000 = Q(alfa1000, K = 2,run=bestrun_alfa1000)
qmatrix_alfa1000

#used this command in the end to generate a barplot, based on http://rstudio-pubs-static.s3.amazonaws.com/381156_02ff3fd76ca546c3bfad06912325e4b8.html:

barplot(t(qmatrix_alfa100),col=c("#CC6677","#322288"),border = NA, space = 0.05, ylab = "Admixture coefficients K = 5", main = "Ancestry matrix", horiz = FALSE, names.arg = c("insert name of each sample"), cex.names = 0.6, las = 2)

###SALVAR MATRIZ Q (pode usar depois no QGIS )

write.csv(qmatrix_alfa1000,"qmatrix.csv")
getwd()
                     