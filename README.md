# scripts-comparative-phylogeography-Amazonian-lizards

Workflow for data processing to obtain the final .vcf for each species and all analyzes from the paper "Phylogeographic discordance in lizards in response to Amazonian wetland configuration and ecological specialization", following the steps to use each script, their description and specification on version of each software. The scripts are structured following the module system of the  National Academic Infrastructure for Supercomputing in Sweden (NAISS).

step 0. Assessing quality using FastQC 0.11.9
script 0_fastqc_quality_check.sh

Step1. Removing adapters from each library Trimmomatic 0.39
script 1_trimmmomatic.sh

Step2. Mapping reads with reference genomes BWA 0.7.17 
script 2_1_bwa_script_sbatch_map.sh
script 2_2_BWA_running_array.sh

Step3. Removing Duplicates and Replacing Read Groups in Picard 2.27.5
script 3_1_prepare_to_GATK_array.sh
script 3_2_call_preparetoGATK.sh

Step4. Calling SNPs and indels and genotyping using GATK 4.5.0.0
script 4_2_call_haploCallGATK.sh
script 4_3_GenotypeGVCFs.sh

Step5. Implementing hard filtering parameters following Lou et al.2021 (https://doi.org/10.1111/mec.16077) for low-coverage whole genome sequencing in GATK
script 5_bcftools_hard_filtering_Lou.sh

Step 6. Implementing filters using the packages “vcfR”, “SNPfiltR”, “dartR”, and “pcadapt” in the R software environment.
script 6_Filtering_SNPs.R

Step 7. Extraction of mitochondrial DNA from whole genome sequecing using MitoFinder 1.4.1
script 7_1_mitofinder_manu_teste1.sh
script 7_2_call_mitofinder_manu_teste1.sh

Step 8. Estimating genetic structure using the sNMF function implemented in the LEA R package.
script 8_snmf.R

Step 9. Principal Component Analysis (PCA) in Plink 2.0
script 9_1_plink_linkagepruning.sh
script 9_2_plink_geno-counts.sh
script 9_3_plink_pca.sh
script 9_4_plink_plot_PCA.R

Step 10. Implementing the Estimated Effective Migration Surface (EEMS)
script 10_dist_matrix_adegenet.R
script 10_1_u_eems.coord
script 10_2_u_eems.diffs
script 10_3_u_eems.outer
script 10_4_n_eems.coord
script 10_5_n_eems.diffs
script 10_6_n_eems.outer

Step 11. Genetic diversity metrics in vcftools 0.1.16.
script 11_1_allele_freq_loop.sh
script 11_2_heterozygosity_loop.sh
script 11_3_nucleotide_div_loop.sh

Step 12. Coalescent-based method in SNAPP and BEAST 2.6.7.
script 12_1_Matschiner-Dating SNPs with SNAPP-workflow MVS

Step 13. Maximum likelihood analysis in TREEMIX 1.13, scripts were based on https://github.com/carolindahms/TreeMix
script 13_1_TreeMix_functions.R
script 13_2_Step1_TreeMix.sh
script 13_3_Step2&4_TreeMix_MVS.R
script 13_4_Step3_TreeMix.sh

Step 14. ABBA-BABA
*no script was used for this analysis, only applying the command 'Dtrios' with inputs that will be available in DRYAD

Step 15. Coalescent Bayesian Skyline analysis in BEAST 1.10.4.
script 15_1_east_xingu_conc.xml
script 15_2_LTAP_conc.xml
script 15_3_MSEDI_conc.xml
script 15_4_northAMZ_conc.xml
script 15_5_sol_conc.xml
script 15_6_UMAD_conc.xml
script 15_8_neusticurus_conc.xml
script 15_9_BSP.sh

