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
#SBATCH -J u_plink_pca
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/plink_pca.U.err
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/plink_pca.U.out

###########################################
### Use plink to perform PCA
### based on https://speciationgenomics.github.io/pca/
############################################

# ------------------------------------------------------------------------------
# Variables - PATH to be called
# ------------------------------------------------------------------------------

module load UPPMAX/1.0.0  bioinfo-tools
module load bioinfo-tools/test_1.0.0
module load plink2/2.00-alpha-5-20230923

VCF="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/vcfs_GATK/uranoscodon_Neutral.vcf"
plink_dir="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/plink_PCA"

plink2 --vcf $VCF --double-id --allow-extra-chr --set-missing-var-ids @:# \
--extract $plink_dir/Uranoscodon.prune.in \
--make-bed --read-freq $plink_dir/Uranoscodon.gcount --pca --out $plink_dir/Uranoscodon
