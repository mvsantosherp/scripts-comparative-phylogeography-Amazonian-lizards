#!/bin/bash

##############################################
##############script teste fastqc#############
##############################################

#########################################
######## Manuela Santos #################
####### manuelasantos237@gmail.com ######
############## 2024 #####################

###########################################
### Quality check of trimmed reads of WGS
### using fastqc
#############################################

#SBATCH -A NAISS2024-22-276
#SBATCH -n 1
#SBATCH -J fastqc_quality_trimmed
#SBATCH --time=1-00:00:00
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/fastqc_qualitytrimm.err.out
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/fastqc_qualitytrimm.st.out
#SBATCH -p main

ml PDC
ml systemdefault/1.0.0
ml fastqc/0.12.1

fastqc fastq/*fastq.gz -t 256 -o quality_trimmed_fastqc