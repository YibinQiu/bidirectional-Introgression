#!/bin/bash

# Job name:
#SBATCH --job-name=dtrios

#SBATCH --partition=fatPartiton
# Number of nodes needed for use case:
#SBATCH --nodes=1
#
# Tasks per node based on number of cores per node:
#SBATCH --ntasks-per-node=1
#
# Processors per task:
#SBATCH --cpus-per-task=128
#
# Memory per node:
#SBATCH --mem=200G

dtrio=/home/qiuyb/bio_soft/Dsuite-master/utils

input=/home/qiuyb/China_pigs/call_variant/unphased

input2=/home/qiuyb/China_pigs/Dusite_result/0.data

output=/home/qiuyb/China_pigs/Dusite_result/1.dtrio

chr=(`seq 1 18`)
unphased_chr=""
for i in `seq 0 17`; do
        unphased_chr=${unphased_chr}"${input}/CHR${chr[$i]}_maf005_geno01.vcf.gz "
done
echo ${unphased_chr}

cd $output
${dtrio}/DtriosParallel --cores 128 -n unphasedrmMix ${input2}/pop_used ${unphased_chr}
