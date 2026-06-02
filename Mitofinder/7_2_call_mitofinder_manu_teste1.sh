#!/bin/bash

#########################################
######## Manuela Santos #################
####### manuelasantos237@gmail.com ######
############## 2024 #####################

###################################################
### This script runs MitoFinder in array mode to
### multiple .sh files
### where --array=1-17%17 (total samples%n per run)
###################################################

#SBATCH -A NAISS2024-22-1237
#SBATCH -p shared
#SBATCH --time=4-00:00:00
#SBATCH --mem=24G
#SBATCH --cpus-per-task=4
#SBATCH -n 1
#SBATCH -J mitofinder_array
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/mitofinder_array.err
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/mitofinder_array.out

# ------------------------------------------------------------------------------
# Variables & Modules
# ------------------------------------------------------------------------------

# Call with sbatch --array=1-17%17 call_mitofinder_teste1.sh

module load UPPMAX/1.0.0 
module load bioinfo-tools/test_1.0.0
module load python/2.7.6

working_dir="/cfs/klemming/projects/snic/amaz_lizard/MitoFinder"

# ------------------------------------------------------------------------------
# Run pipeline
# ------------------------------------------------------------------------------

cd $working_dir

THIS_IND=`awk "NR==$SLURM_ARRAY_TASK_ID" list_trimmed_reads.txt`

bash sbatch_scripts/${THIS_IND}