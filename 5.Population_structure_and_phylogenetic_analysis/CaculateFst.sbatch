#!/bin/bash
# Job name:
#SBATCH --job-name=CaculateFst.sbatch
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
output=/home/qiuyb/China_pigs/Fst
input2=/home/qiuyb/China_pigs/selscan_europ/0.data
cd $output
mkdir -p $output/logs
eup_breeds=(SYWB ZJWB NCWB NoCWB WZS LUC BMX TT YNT RC NJ SCT BS GST JH JQH EHL MS WNB WNS ASP BAM HT LWU MIN LIC CDUR ADUR TDUR HAM DLY WLR FLR NLR BK PIT LW EWB)
china_breeds=(SYWB ZJWB NCWB NoCWB WZS LUC BMX TT YNT RC NJ SCT BS GST JH JQH EHL MS WNB WNS ASP BAM HT LWU MIN LIC CDUR ADUR TDUR HAM DLY WLR FLR NLR BK PIT LW EWB)

for i in {0..37}  ##BreedsNumber-2
do
    cat ${input2}/indInfo2.txt|grep "${eup_breeds[$i]} "|awk '{print $1}' >${input2}/${eup_breeds[$i]}.txt
    for j in {0..37}  ##BreedsNumber+1
    do

        cat ${input2}/indInfo2.txt|grep "${china_breeds[$j]} "|awk '{print $1}' >${input2}/${china_breeds[$j]}.txt
        vcftools --gzvcf ${input1}/418sample_QC_maf005_geno01.vcf.gz --weir-fst-pop ${input2}/${eup_breeds[$i]}.txt --weir-fst-pop ${input2}/${china_breeds[$j]}.txt --fst-window-size 50000 --fst-window-step 25000 --out ${output}/${eup_breeds[$i]}_${china_breeds[$j]} >${output}/logs/${eup_breeds[$i]}_${china_breeds[$j]}.log 2>&1 &
    done
    wait
done
sacct -j $SLURM_JOB_ID --units=G -P --format="Account%15,JobID,JobName%15,CPUTime,Elapsed,MaxRSS,Start,End,NodeList,NTasks,Partition%20,NCPUS,state"

