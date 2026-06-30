#!/bin/bash

#########################################
######## Manuela Santos #################
####### manuelasantos237@gmail.com ######
############## 2024 #####################

###########################################
#### Script to run BSP with .xml file
#############################################

#SBATCH -A NAISS2024-22-1237
#SBATCH -p shared
#SBATCH --time=2-00:00:00
#SBATCH --mem=100GB
#SBATCH --cpus-per-task=12
#SBATCH -n 1
#SBATCH -J bsp_ura
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/bsp_ura.err
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/bsp_ura.out

# ------------------------------------------------------------------------------
# Variables
# in case of modules, not needed, but needed fot installed softwares in the cluster
# ------------------------------------------------------------------------------

module load bioinfo-tools
module load beast2/2.7.3

input_dir="full path to .xml"


beast -seed 223456 -threads 8  -beagle $input_dir/FILE.xml
