#!/bin/bash

# Job name:
#SBATCH --job-name=beagle_ibd
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
#SBATCH --cpus-per-task=24
#
# Memory per node:
#SBATCH --mem=64G
#
## Wall clock limit (one of "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds"):
##SBATCH --time=4:00:00

# Usage: sbatch beagle_ibd.sbatch chrNo

chr=$1

INPUT=/home/qiuyb/China_pigs/call_variant/unphased
OUTPUT=/home/qiuyb/China_pigs/rIBD/1.IBD
BEAGLE=/home/qiuyb/bio_soft/beagle.27Jul16.86a.jar

#tmp=(`seq 1 10`)

for i in `seq 1 10`
do
{
        time java -Xss2000m -jar ${BEAGLE} \
                gt=${INPUT}/CHR${chr}_maf005_geno01.vcf.gz \
                out=${OUTPUT}/CHR_${chr}_tmp${i} \
                nthreads=2 \
                niterations=10 \
                impute=false \
                ibd=true \
                seed=$RANDOM \
                window=20000 \
                overlap=5000
} &
done
wait
