#!/bin/bash

##############################################
#############script running BWA###############
##############################################

#########################################
######## Manuela Santos #################
####### manuelasantos237@gmail.com ######
############## 2024 #####################

###################################################
### This script runs BWA in array mode to
### multiple .sh files
### where --array=1-74%10 (total samples%n per run)
###################################################

#SBATCH -A NAISS2024-22-276
#SBATCH --partition=shared
#SBATCH --time=1-00:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem-per-cpu=4G
#SBATCH --job-name=bwa_array
#SBATCH --error=/cfs/klemming/projects/snic/amaz_lizard/error/bwa_uranoscodon.job%a.err
#SBATCH --output=/cfs/klemming/projects/snic/amaz_lizard/error/bwa_uranoscodon.job%a.out

# ------------------------------------------------------------------------------
# Variables & Modules
# ------------------------------------------------------------------------------

# Call with sbatch --array=1-74%10 call_script_sbatch_map_uranodoscon.sh

module load UPPMAX/1.0.0
module load bioinfo-tools/test_1.0.0
module load PDC
module load systemdefault/1.0.0
module load bwa/0.7.17
module load samtools/1.20

working_dir="/cfs/klemming/projects/snic/amaz_lizard/scripts"

# ------------------------------------------------------------------------------
# Run pipeline
# ------------------------------------------------------------------------------

cd $working_dir

THIS_IND=`awk "NR==$SLURM_ARRAY_TASK_ID" list_sbatch.txt`

bash sbatch_bwa/${THIS_IND}
