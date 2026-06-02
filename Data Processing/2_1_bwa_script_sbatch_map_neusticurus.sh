#!/bin/bash

##############################################
##############script BWA##############
##############################################

#########################################
######## Manuela Santos #################
####### manuelasantos237@gmail.com ######
############## 2024 #####################

###########################################
### This script is going to read a tabular
### file and prepare separate .sh file for 
### each species to run bwa in a array mode
#############################################

data_dir='PATH TO TRIMMED READS'
reference_dir='PATH TO REFERENCE GENOME'
scracth_dir='PATH TO SCRATCH FILES'
out_dir='PATH TO OUTPUT FOLDER'
sbatch_bwa='PATH TO SBATCH FILES'

while read line; do
        pop=$(echo $line | awk '{print $1}')
        sampleID=$(echo $line | awk '{print $2}')
        identifier_fq=$(echo $line | awk '{print $3}') 

        echo "#!/bin/bash

bwa mem -t 8 $reference_dir/FILE.fna $data_dir/${sampleID}_${identifier_fq}_Trim_1.fastq.gz $data_dir/${sampleID}_${identifier_fq}_Trim_2.fastq.gz | samtools sort -@ 8 -m 3G -O bam -T $scracth_dir/${sampleID} -o $out_dir/mapped_bwa/N_${sampleID}_${pop}.sorted.bam" > $sbatch_bwa/${sampleID}.bwa.sh

done < mapp_renamed.txt