#!/bin/bash

# Job name:
#SBATCH --job-name=GenerateFinalNJtree.sbatch
#
# Number of nodes needed for use case:
#SBATCH --nodes=1
#
#SBATCH --partition=computerPartiton,fatPartiton
#
# Tasks per node based on number of cores per node:
#SBATCH --ntasks-per-node=1
#
# Processors per task:
#SBATCH --cpus-per-task=23
#
# Memory per node:
#SBATCH --mem=24G
### software source
## VCF2Dis: https://github.com/BGI-shenzhen/VCF2Dis
## fneighbor: ftp://emboss.open-bio.org/pub/EMBOSS/ #若edge打不开,可用 filezilla 站点：emboss.open-bio.org,匿名
## consense: http://evolution.genetics.washington.edu/phylip.html
## INSTALL_GUIDE (chinese): https://github.com/hewm2008/VCF2Dis/blob/main/Install.NJ.cn.md

input=/home/qiuyb/China_pigs/NJ_tree/0.data
output=/home/qiuyb/China_pigs/NJ_tree/1.NJtree
mkdir -p $output

pop=$1
mkdir -p $output/${pop}
cd $output/${pop}

##generate bootstrap
for bootstrap in {1..100}; do
        VCF2Dis -InPut ${input}/${pop}_QC_autosome_maf005_geno01_updateFidIID_adjustreference.vcf.gz -OutPut ${pop}.${bootstrap}.mat -Rand 0.25;
        fneighbor -datafile ${pop}.${bootstrap}.mat -outfile ${pop}.${bootstrap}.txt -matrixtype s -treetype n -outtreefile ${pop}.${bootstrap}.tre;
done
cat ${pop}.*.tre > ALLtree_merge.tre
fconsense -intreefile ALLtree_merge.tre -outfile out -treeprint Y
perl ~/bio_soft/VCF2Dis-1.46/bin/percentageboostrapTree.pl alltree_merge.treefile 100 Final_${pop}_boostrap.tre
