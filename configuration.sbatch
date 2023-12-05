#!/bin/bash

# Job name:
#SBATCH --job-name=configuration.sbatch
#SBATCH --partition=computerPartiton
# Number of nodes needed for use case:
#SBATCH --nodes=1
#
# Processors per task:
#SBATCH --cpus-per-task=4
#
# Memory per node:
#SBATCH --mem=24G
#SBATCH --output=configuration.out
#SBATCH --error=configuration.err

# ============================================================
source /home/qiuyb/bio_soft/MANTA_ENV/bin/activate
MANTA_INSTALL_PATH=/home/qiuyb/bio_soft/MANTA_ENV/share/manta-1.6.0-2
sample=(`cat /home/qiuyb/China_pigs/manta_sv/0.data/sample.txt |awk '{print $2}'`)
echo "SLURM_JOB_ID: $SLURM_JOB_ID"

ref=/home/qiuyb/resource/swim/Sus_scrofa.Sscrofa11.1.dna.toplevel.fa
region=/home/qiuyb/China_pigs/manta_sv/0.data/call_region.txt.gz

for bamsample in `echo NCWB_SRS465716`
do
    input=/home/qiuyb/China_pigs/pigWGS/${bamsample}
    mkdir -p /home/qiuyb/China_pigs/manta_sv/1.configuration/${bamsample}
    MANTA_ANALYSIS_PATH=/home/qiuyb/China_pigs/manta_sv/1.configuration/${bamsample}

    if [ -e $input/${bamsample}.mkdup.bai -o -e $input/${bamsample}.mkdup.bam.bai ] && [ -e $input/${bamsample}.mkdup.bam ] 
    then
        >&2 echo "$(date +"%Y-%m-%d %T") begin configuration for ${bamsample}"
    else
        >&2 echo "$(date +"%m-%d-%Y-%T"):error: cannot find bam in $input."
        echo ${bamsample} >> /home/qiuyb/China_pigs/manta_sv/0.data/noBamSample.txt
        exit 1
    fi

    ${MANTA_INSTALL_PATH}/bin/configManta.py \
    --bam ${input}/${bamsample}.mkdup.bam \
    --referenceFasta $ref \
    --runDir ${MANTA_ANALYSIS_PATH} \
    --callRegions $region
done
