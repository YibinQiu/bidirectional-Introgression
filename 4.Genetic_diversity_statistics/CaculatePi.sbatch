#!/bin/bash
# Job name:
#SBATCH --job-name=CaculatePi.sbatch
#
#SBATCH --partition=computerPartiton

# Number of nodes needed for use case:
#SBATCH --nodes=1
#
# Tasks per node based on number of cores per node:
#SBATCH --ntasks-per-node=1
#
# Processors per task:
#SBATCH --cpus-per-task=23
#
# Memory per node:
#SBATCH --mem=24G
echo "SLURM_JOB_ID: $SLURM_JOB_ID"
input1=/home/qiuyb/China_pigs/call_variant
output=/home/qiuyb/China_pigs/pi
input2=/home/qiuyb/China_pigs/selscan_europ/0.data
cd $output
mkdir -p $output/logs
breeds=(ADUR CDUR TDUR LW WLR FLR NLR PIT HAM BK NCN ECN SCN SWCN EWB CNWB)

for i in {0..12}  ##BreedsNumber-2
do
         vcftools --gzvcf ${input1}/418sample_QC_maf005_geno01.vcf.gz --keep ${input2}/${breeds[$i]}.txt --window-pi 50000 --window-pi-step 25000  --out ${output}/${breeds[$i]} >${output}/logs/${breeds[$i]}.log 2>&1 &
done
wait
