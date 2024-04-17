#!/bin/bash
#SBATCH --job-name=LD_decay
#SBATCH --nodes=1
#SBATCH -w cu08
#SBATCH -p computerPartiton
#SBATCH --cpus-per-task=3
#SBATCH --mem=200G
#SBATCH --array=0-6%7
#SBATCH --output=log_%A_%a.out

sample=(`cat /home/qiuyb/China_pigs/structure/region.txt`)
input=/home/qiuyb/China_pigs/structure/0.data
output=/home/qiuyb/China_pigs/structure/LD
vcf=/home/qiuyb/China_pigs/call_variant/418sample_QC_maf005_geno01_renamevarid_autome.vcf.gz

echo  $(date +"%Y-%m-%d %T") begin calculate LD decay for ${sample[SLURM_ARRAY_TASK_ID]}
PopLDdecay \
-InVCF  $vcf  \
-MaxDist 500 -MAF 0 -Het 1 -Miss 1 \
-OutStat  ${output}/${sample[SLURM_ARRAY_TASK_ID]}.stat.gz  \
-SubPop ${input}/${sample[SLURM_ARRAY_TASK_ID]}.list

echo  $(date +"%Y-%m-%d %T") done for ${sample[SLURM_ARRAY_TASK_ID]}
