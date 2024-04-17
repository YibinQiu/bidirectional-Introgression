#!/bin/bash

# Job name:
#SBATCH --job-name=pca.sbatch
#SBATCH --partition=computerPartiton
# Number of nodes needed for use case:
#SBATCH --nodes=1
#
# Processors per task:
#SBATCH --cpus-per-task=24
#
# Memory per node:
#SBATCH --mem=200G
#SBATCH --output=pca.out
#SBATCH --error=pca.err
cd /home/qiuyb/China_pigs/structure/PCA

gcta --bfile /home/qiuyb/China_pigs/NJ_tree/0.data/418sample_QC_autosome_maf005_geno01_updateFidIID --make-grm --autosome --out PCA
gcta --grm PCA --pca 5 --out PCA
