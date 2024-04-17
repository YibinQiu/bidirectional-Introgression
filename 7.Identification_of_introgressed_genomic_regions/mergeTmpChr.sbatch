#!/bin/bash

# Job name:
#SBATCH --job-name=mergeTmpChr.sbatch
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

input=/home/qiuyb/China_pigs/rIBD/1.IBD
sbatch_mergepy=/home/qiuyb/China_pigs/rIBD/sbatch
cd $input

for chr in `seq 1 18`
do

    touch CHR_${chr}.ibd
    for i in `seq 1 10`
    do
        cat CHR_${chr}.ibd CHR_${chr}_tmp${i}.ibd > tmp${chr}
        mv tmp${chr} CHR_${chr}.ibd
    done
    awk '{print $1,$3,$2*2+$4,$5,$6,$7}' CHR_${chr}.ibd |sort -k1,1 -k2,2 -k4,4n -k5,5n -k6,6n > CHR_${chr}.ibd.sort
    python ${sbatch_mergepy}/merge.py -i CHR_${chr}.ibd.sort -c ${chr} -o CHR_${chr}.ibd.merge
    echo "CHR_${chr}.ibd.merge done"

done
