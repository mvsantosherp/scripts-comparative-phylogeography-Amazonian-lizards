#!/bin/bash

#########################################
######## Manuela Santos #################
###### manuelasantos237@gmail.com #######
############## 2024 #####################

#SBATCH -A NAISS2024-22-276
#SBATCH -p shared
#SBATCH --time=4-00:00:00
#SBATCH --mem=24G
#SBATCH --cpus-per-task=2
#SBATCH -n 1
#SBATCH -J u_plink_linkprun
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/plink1_Knipo.U.err
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/plink1_Knipo.U.out

###########################################
### Use plink to perform linkage pruning 
### - i.e. identify prune sites
### based on https://speciationgenomics.github.io/pca/
### and https://www.cog-genomics.org/plink/2.0/
############################################

# ------------------------------------------------------------------------------
# Variables - PATH to be called
# ------------------------------------------------------------------------------

module load UPPMAX/1.0.0  bioinfo-tools
module load bioinfo-tools/test_1.0.0
module load plink2/2.00-alpha-5-20230923

VCF="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/vcfs_GATK/uranoscodon_Neutral.vcf"
out_dir="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/plink_PCA"

plink2 --vcf $VCF --double-id --allow-extra-chr \
--set-missing-var-ids @:# \
--indep-pairwise 50 10 0.1 --out $out_dir/Uranoscodon --bad-ld
