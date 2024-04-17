#!/bin/bash

# Job name:
#SBATCH --job-name=mergediploidSV.sbatch
#SBATCH --partition=computerPartiton
# Number of nodes needed for use case:
#SBATCH --nodes=1
#
# Processors per task:
#SBATCH --cpus-per-task=24
#
# Memory per node:
#SBATCH --mem=128G
#SBATCH --output=mergediploidSV.out
#SBATCH --error=mergediploidSV.err

# ============================================================
cd /home/qiuyb/China_pigs/manta_sv/2.mergeSV
ls /home/qiuyb/China_pigs/manta_sv/1.configuration/*/results/variants/diploidSV.vcf.gz > input_vcfs



source  ~/bio_soft/GRAPHTYPER_ENV/bin/activate
echo "SLURM_JOB_ID: $SLURM_JOB_ID"
echo "$(date +"%Y-%m-%d %T") begin merge SV"
svimmer input_vcfs `seq 1 18` | bgzip -c > merged.vcf.gz
tabix merged.vcf.gz
echo "$(date +"%Y-%m-%d %T") done"
