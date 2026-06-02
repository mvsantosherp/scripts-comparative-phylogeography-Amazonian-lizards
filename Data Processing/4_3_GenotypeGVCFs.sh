#!/bin/bash

#########################################
######## Manuela Santos #################
####### manuelasantos237@gmail.com ######
############## 2024 #####################

###########################################
### Script to use the 'GenotypeGVCFs' 
### tool of GATK to perform joint genotyping 
### in combined .gvcf file and resulting in
### a final VCF with all samples genotyped to 
### SNPs filtering
#############################################

#SBATCH -A NAISS2024-22-276
#SBATCH -p shared
#SBATCH --time=3-00:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=4
#SBATCH -n 1
#SBATCH -J genotypeGVCFs.GATK.N
#SBATCH -e PATH.GATK.N.err
#SBATCH -o PATH.GATK.N.out

# ------------------------------------------------------------------------------
# Variables & Modules
# ------------------------------------------------------------------------------

gvcf_dir="PATH TO GVCF"
reference_dir="PATH TO REFERENCE .FNA"
out_dir="PATH TO OUTPUT"

module load systemdefault/1.0.0
module load gatk/4.5.0.0

gatk --java-options "-Xmx10g" GenotypeGVCFs -R $reference_dir/REFERENCE.fna -V $gvcf_dir/GATK.gvcf -O $out_dir/finVCF.vcf