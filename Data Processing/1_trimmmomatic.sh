#!/bin/bash
#!/bin/bash
#SBATCH -A NAISS2024-22-276
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -J fastqc_qualityteste_all
#SBATCH --time=1-00:00:00
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/fastqc_qualityraw.err
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/fastqc_qualityraw.out
#SBATCH -p main

ml load trimmomatic
ml  UPPMAX/1.0.0
ml gnuparallel/20170122

adapter_dir='/pdc/software/eb/software/trimmomatic/0.39/adapters'
rawdata_dir='/cfs/klemming/projects/snic/amaz_lizard/fastq'
trimmed_dir='/cfs/klemming/projects/snic/amaz_lizard/trimmed_reads'

cd $rawdata_dir/

ls *_R1_001.fastq.gz | sed 's/_R1_001.fastq.gz//' | parallel --resume-failed --jobs 3 --joblog trimmomatic PE -threads 64 {}_R1_001.fastq.gz {}_R2_001.fastq.gz $trimmed_dir/{}.R1.Ptrim.fq $trimmed_dir/{}.R1.Utrim.fq $trimmed_dir/{}.R2.Ptrim.fq $trimmed_dir/{}.R2.Utrim.fq ILLUMINACLIP:ILLUMINACLIP:$adapter_dir/TruSeq3PE2.fa:2:30:10 SLIDINGWINDOW:10:2 0 LEADING:20 TRAILING:20 MINLEN:35 AVGQUAL:20
(base) mvsantos@login1:/cfs/klemming/projects/snic/amaz_lizard/scripts> rm trimmomatic.sh
(base) mvsantos@login1:/cfs/klemming/projects/snic/amaz_lizard/scripts> cat trimmomatic_noGNU.sh 
#!/bin/bash
#SBATCH -A NAISS2024-22-276
#SBATCH -n 1
#SBATCH -J fastqc_qualityteste_all
#SBATCH --time=1-00:00:00
#SBATCH -e /cfs/klemming/projects/snic/amaz_lizard/error/fastqc_qualityraw.err
#SBATCH -o /cfs/klemming/projects/snic/amaz_lizard/error/fastqc_qualityraw.out
#SBATCH -p main

ml PDC
ml UPPMAX/1.0.0
ml trimmomatic

source /opt/cray/pe/cpe/23.12/restore_lmod_system_defaults.sh

adapter_dir='/pdc/software/eb/software/trimmomatic/0.39/adapters'
rawdata_dir='/cfs/klemming/projects/snic/amaz_lizard/fastq'
trimmed_dir='/cfs/klemming/projects/snic/amaz_lizard/trimmed_reads'

cd $rawdata_dir/

ls *_R1_001.fastq.gz | sed 's/_R1_001.fastq.gz//' | trimmomatic PE -threads 12 {}_R1_001.fastq.gz {}_R2_001.fastq.gz $trimmed_dir/{}.R1.Ptrim.fq $trimmed_dir/{}.R1.Utrim.fq $trimmed_dir/{}.R2.Ptrim.fq $trimmed_dir/{}.R2.Utrim.fq ILLUMINACLIP:$adapter_dir/TruSeq3PE2.fa:2:30:10 SLIDINGWINDOW:10:2 0 LEADING:20 TRAILING:20 MINLEN:35 AVGQUAL:20
