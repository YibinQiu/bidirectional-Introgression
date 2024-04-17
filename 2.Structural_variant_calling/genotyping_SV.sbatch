#!/bin/bash

# Job name:
#SBATCH --job-name=genotyping_SV.sbatch
# Number of nodes needed for use case:
#SBATCH --nodes=1
#
# Processors per task:
#SBATCH --cpus-per-task=48
#
# Memory per node:
#SBATCH --mem=200G
#SBATCH --output=genotyping_SV_%A.out
#SBATCH --error=genotyping_SV_%A.err

source ~/bio_soft/GRAPHTYPER_ENV/bin/activate
cd /home/qiuyb/China_pigs/manta_sv/4.genotyping
ref=/home/qiuyb/resource/swim/Sus_scrofa.Sscrofa11.1.dna.toplevel.fa
vcf=/home/qiuyb/China_pigs/manta_sv/2.mergeSV/merged.vcf.gz
BAMLIST=/home/qiuyb/China_pigs/manta_sv/3.avg_cov/BAMLIST
AVG_COV=/home/qiuyb/China_pigs/manta_sv/3.avg_cov/BAMLIST.avg_cov_by_readlen

chr=$1
end=`zcat /home/qiuyb/China_pigs/manta_sv/0.data/call_region.txt.gz |awk '{if($1=="'"$chr"'")print $3}'`

echo "$(date +"%Y-%m-%d %T") start chr$chr:1-$end"
graphtyper genotype_sv $ref $vcf --sams=$BAMLIST --region=$chr:1-${end} --avg_cov_by_readlen=$AVG_COV --log=chr$chr.log --verbose --threads=48
echo "$(date +"%Y-%m-%d %T") done"
