#!/bin/bash

ml vcftools

# Directory where your VCF files are located
VCF_DIR="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/vcfs_GATK/final_dataset_uranoscodon/subsets"

# Output directory where you want to store results
OUTPUT_DIR="/cfs/klemming/projects/snic/amaz_lizard/U_superciliosus/vcfs_GATK/final_dataset_uranoscodon/subsets"

# Window size (example: 100000 for 100kb windows)
WINDOW_SIZE=100000

# Step size for sliding window (example: 50000 for 50kb steps)
STEP_SIZE=50000

# Loop through each VCF file in the VCF directory
for VCF_FILE in "$VCF_DIR"/*.vcf; do
    # Extract the file name without the path and extension
    FILE_NAME=$(basename "$VCF_FILE" .vcf)
    
    # Output file for --window-pi results
    OUTPUT_FILE="$OUTPUT_DIR/${FILE_NAME}_window_pi.txt"
    
    # Run vcftools with --window-pi for each VCF file
    vcftools --vcf "$VCF_FILE" --window-pi "$WINDOW_SIZE" --window-pi-step "$STEP_SIZE" --out "$OUTPUT_FILE"
    
    echo "Processed $VCF_FILE, output saved to $OUTPUT_FILE"
done
