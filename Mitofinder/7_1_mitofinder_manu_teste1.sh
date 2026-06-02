#!/bin/bash

#########################################
######## Manuela Santos #################
###### manuelasantos237@gmail.com #######
############## 2024 #####################


#########################################
###
### script to generate sbatch files to 
### running MitoFinder on all samples 
### in list. 
### MitoFinder version 1.4.1
###
##########################################

#SBATCH -A NAISS2024-22-1237
#SBATCH -p shared
#SBATCH --time=4-00:00:00
#SBATCH --mem=24G
#SBATCH --cpus-per-task=4
#SBATCH -n 1
#SBATCH -J mitofinder
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/mitofinder.err
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/mitofinder.out

# ------------------------------------------------------------------------------
# Variables/Modules - PATH to be called
# ------------------------------------------------------------------------------

ref_dir="path to reference"
trim_dir="path/trimmed_reads"
mito_dir="path/MitoFinder"

while read line; do
	sampleID=$(echo $line | awk '{print $1}') 	


cd $mito_dir

./mitofinder -j ${sampleID} --override -1 $trim_dir/${sampleID}_Trim_1.fastq.gz -2 $trim_dir/${sampleID}_Trim_2.fastq.gz -r $ref_dir/file.gb -t arwen -o 2 -p 12 -m 10" > path/sbatch_scripts/$sampleID.mitofinder.sh; 
done < samples_mitofinder.txt
