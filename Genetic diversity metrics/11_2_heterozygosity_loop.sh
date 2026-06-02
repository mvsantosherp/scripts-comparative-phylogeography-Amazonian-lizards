#!/bin/bash

ml vcftools

# Directory where your VCF files are located
VCF_DIR="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/vcfs_GATK/final_dataset_uranoscodon/subsets"

# Directory to save the output
OUTPUT_DIR="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/vcfs_GATK/final_dataset_uranoscodon/subsets"

# Make sure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Loop through each VCF file
for VCF_FILE in "$VCF_DIR"/*.vcf; do
    # Get the base filename (without path and extension)
    BASE_NAME=$(basename "$VCF_FILE" .vcf)

    # Run vcftools --het
    vcftools --vcf "$VCF_FILE" --het --out "$OUTPUT_DIR/${BASE_NAME}_het"

    echo "Processed $VCF_FILE, output saved to ${BASE_NAME}_het.het"
done
