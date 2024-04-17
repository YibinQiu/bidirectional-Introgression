#!/bin/bash
#SBATCH -N 1
# Job name:
#SBATCH --job-name=admixture_computerPartiton.sbatch
#SBATCH --partition=computerPartiton
#SBATCH --exclude=cu02
#SBATCH --cpus-per-task=24
#SBATCH --mem=200G
input=/home/qiuyb/China_pigs/NJ_tree/0.data
output=/home/qiuyb/China_pigs/NJ_tree/2.admixture_repeat

repeat=$1 #repeat 1-10
mkdir -p $output/repeat_${repeat}
cd $output/repeat_${repeat}
for K in {1..20}
do
    echo $(date +"%Y-%m-%d"-%T) begin for $K
    admixture --cv ${input}/cleanBinaryPruned.bed ${K} -j128 -s ${repeat} | tee log${K}.${repeat}.out;
done
