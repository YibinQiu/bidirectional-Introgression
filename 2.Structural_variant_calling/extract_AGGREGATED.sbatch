#!/bin/bash

# Job name:
#SBATCH --job-name=extract_AGGREGATED.sbatch
#SBATCH --partition=computerPartiton
# Number of nodes needed for use case:
#SBATCH --nodes=1
#
# Processors per task:
#SBATCH --cpus-per-task=24
#
# Memory per node:
#SBATCH --mem=200G
#SBATCH --output=extract_AGGREGATED.out
#SBATCH --error=extract_AGGREGATED.err
source ~/bio_soft/VCFLIB_ENV/bin/activate
cd /home/qiuyb/China_pigs/manta_sv/4.genotyping
vcffilter -f "SVTYPE = BND & SVMODEL = AGGREGATED" raw_mergedSV.vcf.gz | bgzip -c > BND_AGGREGATED.vcf.gz &
vcffilter -f "SVTYPE = DEL & SVMODEL = AGGREGATED" raw_mergedSV.vcf.gz | bgzip -c > DEL_AGGREGATED.vcf.gz &
vcffilter -f "SVTYPE = DUP & SVMODEL = AGGREGATED" raw_mergedSV.vcf.gz | bgzip -c > DUP_AGGREGATED.vcf.gz &
vcffilter -f "SVTYPE = INS & SVMODEL = AGGREGATED" raw_mergedSV.vcf.gz | bgzip -c > INS_AGGREGATED.vcf.gz &
vcffilter -f "SVTYPE = INV" raw_mergedSV.vcf.gz | bgzip -c > INV_AGGREGATED.vcf.gz & #only breakpoint model
wait
tabix -p vcf BND_AGGREGATED.vcf.gz &
tabix -p vcf DEL_AGGREGATED.vcf.gz &
tabix -p vcf DUP_AGGREGATED.vcf.gz &
tabix -p vcf INS_AGGREGATED.vcf.gz &
tabix -p vcf INV_AGGREGATED.vcf.gz &
wait
