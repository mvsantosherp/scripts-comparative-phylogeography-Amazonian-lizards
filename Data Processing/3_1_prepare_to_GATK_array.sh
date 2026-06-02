#!/bin/bash

#########################################
######## Manuela Santos #################
####### manuelasantos237@gmail.com ######
############## 2024 #####################

###########################################
### 1. generate scripts to run picard and 
### prepare samples to call the variants
### The .sh files for each sample is built
### using as a input a tab delimited file
### with the columns being the basic info for 
### every directory with bam_files, and reference
### genomes used to map the samples using bwa
#############################################

# ------------------------------------------------------------------------------
# Variables
# in case of modules, not needed, but needed fot installed softwares in the cluster
# ------------------------------------------------------------------------------

BAM_directories="PATH TO BAM"
reference_dir="PATH TO REFERENCE FNA"
scripts_dir="/PATH TO SCRIPTS"
stats_dir='PATH TO STATS'
picard_out="PATH TO OUTPUTS"
picard_path="PATH TO PICARD APPLICATION"

# ------------------------------------------------------------------------------
# Run pipeline for every sample
# ------------------------------------------------------------------------------

while read line; do
        sampleID=$(echo $line | awk '{print $1}')

         echo "#!/bin/bash

	echo
	echo
	echo Adding Read Group
	echo
	echo

java -jar $picard_path/picard.jar MarkDuplicates \
	TMP_DIR=tmp \
	I=$BAM_directories/${sampleID}.sorted.bam \
	O=$picard_out/${sampleID}_raf.dedup.bam \
	METRICS_FILE=$stats_dir/${sampleID}_raf.dedup.metrics.txt \
	REMOVE_DUPLICATES=true 

	echo
	echo
	echo Deduplication
	echo
	echo

java -jar $picard_path/picard.jar AddOrReplaceReadGroups \
	I=$picard_out/${sampleID}_raf.dedup.bam \
	O=$picard_out/${sampleID}.sorted-gp-add-raf_dedup.bam \
	RGID=4 \
	RGLB=WGS \
	RGPL=ILLUMINA \
	RGPU=barcode \
	CREATE_INDEX=True \
	RGSM=${sampleID}

	echo
	echo "#######################"
	echo $name DONE!
	echo "#######################"
	echo
	echo" > $scripts_dir/${sampleID}.preptoGATK.sh

done < $scripts_dir/list_mapped_sortedbam.txt
