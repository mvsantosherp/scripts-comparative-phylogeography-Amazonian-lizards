#!/bin/bash

#########################################
######## Manuela Santos #################
####### manuelasantos237@gmail.com ######
############## 2024 #####################

############################################
### Call script to use samtools to performe 
### hard filtering to:  mapping and sequencing
### quality filters and also some specific
### filters such as allele frequency, coverage
### and missing data per site.
### Uranoscodon superciliosus
############################################

#SBATCH -A NAISS2024-22-276
#SBATCH -p shared
#SBATCH --time=6-00:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=8
#SBATCH -n 1
#SBATCH -J u_samtools_hardfilter
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/u_samtools_hardfilter.err
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/u_samtools_hardfilter.out

# ------------------------------------------------------------------------------
# Variables & Modules
# ------------------------------------------------------------------------------

bcf_dir="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/vcfs_GATK"

module load systemdefault/1.0.0
module load bcftools/1.20

bcftools filter -e "QD<2 || MQRankSum<-12.5 || FS>60 || SOR>3 || ReadPosRankSum<-8 || QUAL<20 || MQ<20 || MAF<0.05 || MEAN(FORMAT/DP)<0.8 || MEAN(FORMAT/DP)>50 || F_MISSING>0.5" --SnpGap 10 $bcf_dir/uranoscodon_finVCF.bcf.gz -Ob -o $bcf_dir/uranoscodon_finVCF_PARCIAL.bcf.gz
