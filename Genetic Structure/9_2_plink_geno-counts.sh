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
#SBATCH -J u_plink_genocount
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/plink_genocount.U.err
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/plink_genocount.U.out

###########################################
### Use plink to perform calculate Allele frequency
### based on https://www.cog-genomics.org/plink/1.9/basic_stats#freq
### to run pca it is necessary give --read-freq
############################################

# ------------------------------------------------------------------------------
# Variables - PATH to be called
# ------------------------------------------------------------------------------

module load UPPMAX/1.0.0  bioinfo-tools
module load bioinfo-tools/test_1.0.0
module load plink2/2.00-alpha-5-20230923

VCF="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/vcfs_GATK/uranoscodon_Neutral.vcf"
plink_dir="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/plink_PCA"

plink2 --vcf $VCF --geno-counts --allow-extra-chr --out $plink_dir/Uranoscodon
