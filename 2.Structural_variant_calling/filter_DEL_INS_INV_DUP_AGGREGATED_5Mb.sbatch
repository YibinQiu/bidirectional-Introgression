#!/bin/bash

# Job name:
#SBATCH --job-name=filter_DEL_INS_INV_DUP_AGGREGATED_5Mb.sbatch
#SBATCH --partition=computerPartiton
# Number of nodes needed for use case:
#SBATCH --nodes=1
#
# Processors per task:
#SBATCH --cpus-per-task=24
#
# Memory per node:
#SBATCH --mem=200G
#SBATCH --output=filter_DEL_INS_INV_DUP_AGGREGATED_5Mb.out
#SBATCH --error=filter_DEL_INS_INV_DUP_AGGREGATED_5Mb.err
cd /home/qiuyb/China_pigs/manta_sv/4.genotyping
svtypes=(DEL INS INV DUP)
for svtype in ${svtypes[@]}
do
bcftools view --threads 24 -i 'INFO/SVSIZE[0] < 5000000' ${svtype}_AGGREGATED.vcf.gz  -Oz -o ${svtype}_AGGREGATED_5Mb.vcf.gz
tabix -p vcf ${svtype}_AGGREGATED_5Mb.vcf.gz
done
