#!/bin/bash

#########################################
######## Manuela Santos #################
####### manuelasantos237@gmail.com ######
############## 2024 #####################

###########################################
### Script to call scripts for Haplotype
### Call using GATK for multiple samples
### Uranoscodon superciliosus
### REF genome: Iguana delicatissima
### GCA_948472985.1_IguDel_wgdbg2_genomic.fna
#############################################

#SBATCH -A NAISS2024-22-276
#SBATCH -p shared
#SBATCH --time=4-00:00:00
#SBATCH --mem=5G
#SBATCH -n 1 
#SBATCH -J haplotypecall.uranoscodon.GATK
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/haplotypecall.uranoscodon.GATK.job%a.err
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/haplotypecall.uranoscodon.GATK.job%a.out

# ------------------------------------------------------------------------------
# Variables & Modules
# ------------------------------------------------------------------------------

#sbatch --array=1-74%10 call_script_haploCallGATK_U.sh

module load systemdefault/1.0.0
module load gatk/4.5.0.0

working_dir="/cfs/klemming/projects/snic/amaz_lizard/scripts"

# ------------------------------------------------------------------------------
# Run pipeline
# ------------------------------------------------------------------------------

cd $working_dir

THIS_IND=`awk "NR==$SLURM_ARRAY_TASK_ID" list_sbatch_hapCALL_uranoscodon.txt`

bash sbatch_hapCALL_uranoscodon/${THIS_IND}
