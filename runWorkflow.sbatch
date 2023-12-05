#!/bin/bash

# Job name:
#SBATCH --job-name=runWorkflow.sbatch
#SBATCH --partition=computerPartiton
# Number of nodes needed for use case:
#SBATCH --nodes=1
#
# Processors per task:
#SBATCH --cpus-per-task=24
#
# Memory per node:
#SBATCH --mem=128G
#SBATCH --array=0-391%3
#SBATCH --output=runWorkflow_%A_%a.out
#SBATCH --error=runWorkflow_%A_%a.err

# ============================================================
source /home/qiuyb/bio_soft/MANTA_ENV/bin/activate
sample=(`cat /home/qiuyb/China_pigs/manta_sv/0.data/sample.txt |awk '{print $2}'`)
echo "$(date +"%m-%d-%Y-%T"):info: begin workflow for sample ${sample[SLURM_ARRAY_TASK_ID]}"
MANTA_ANALYSIS_PATH=/home/qiuyb/China_pigs/manta_sv/1.configuration/${sample[SLURM_ARRAY_TASK_ID]}

cd $MANTA_ANALYSIS_PATH
${MANTA_ANALYSIS_PATH}/runWorkflow.py -j 24
echo "$(date +"%m-%d-%Y-%T"):info: done"
