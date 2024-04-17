#!/bin/bash

# Job name:
#SBATCH --job-name=concat_SV
#SBATCH --partition=computerPartiton
# Number of nodes needed for use case:
#SBATCH --nodes=1
#
# Processors per task:
#SBATCH --cpus-per-task=24
#
# Memory per node:
#SBATCH --mem=200G
#SBATCH --output=concat_SV.out
#SBATCH --error=concat_SV.err

source ~/bio_soft/GRAPHTYPER_ENV/bin/activate
cd /home/qiuyb/China_pigs/manta_sv/4.genotyping
echo {1..18} X Y | tr ' ' '\n' | while read chrom; do if [[ ! -d sv_results/${chrom} ]]; then continue; fi; find sv_results/${chrom} -name "*.vcf.gz" | sort >> vcf_file_list; done
bcftools concat --naive --file-list vcf_file_list -Oz -o raw_mergedSV.vcf.gz
tabix -p vcf raw_mergedSV.vcf.gz
echo "$(date +"%Y-%m-%d %T") done"
