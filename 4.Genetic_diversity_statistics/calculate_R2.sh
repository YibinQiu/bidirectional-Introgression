#!/bin/bash
#SBATCH --job-name=calculate_R2
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH -p computerPartiton
#SBATCH -w cu06
#SBATCH --mem=64G
##calculate LD
input=/home/qiuyb/dengsx/0.data/418sample_QC_autosome_maf005_geno01_updateFidIID
for i in `awk '{print $1}' $input.ped|sort | uniq`
do
awk '{if($1=="'$i'")print}' $input.ped > ./${i}.ped
cp $input.map ./${i}.map
plink --noweb --file ./${i} --r2 --ld-window-kb 1000 --ld-window-r2 0 --out ./${i}
rm ./${i}.ped ./${i}.map ./${i}.log
done
Rscript LD_decayplot.r
