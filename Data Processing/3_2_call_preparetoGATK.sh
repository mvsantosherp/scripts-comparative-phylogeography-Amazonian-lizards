#!/bin/bash

##############################################
###########script prepare to GATK#############
##############################################

#########################################
######## Manuela Santos #################
####### manuelasantos237@gmail.com ######
############## 2024 #####################

###################################################
### This script runs PICARD in array mode to
### multiple .sh files
### where --array=1-17%17 (total samples%n per run)
###################################################

#SBATCH -A NAISS2024-22-276
#SBATCH --partition=shared
#SBATCH --time=1-00:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem-per-cpu=4G
#SBATCH --job-name=prepare_to_GATK
#SBATCH --error=PATH/FILE.job%a.err
#SBATCH --output=/PATH/FILE.job%a.out

# ------------------------------------------------------------------------------
# Variables & Modules
# ------------------------------------------------------------------------------

# Call with sbatch --array=1-17%17 call_script_sbatch_map_neusticurus.sh

module load UPPMAX/1.0.0
module load bioinfo-tools/test_1.0.0
module load PDC/23.12
module load picard/2.27.5

working_dir="/cfs/klemming/projects/snic/amaz_lizard/scripts"

# ------------------------------------------------------------------------------
# Run pipeline
# ------------------------------------------------------------------------------

cd $working_dir

THIS_IND=`awk "NR==$SLURM_ARRAY_TASK_ID" list_mapped_sortedbam.txt`

bash sbatch_prep/${THIS_IND}