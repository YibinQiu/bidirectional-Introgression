# bidirectional-Introgression
# 1.Read mapping and Variant calling
gatk best practices workflow can be obtained in https://github.com/qgg-lab/swim-public.
# 2.Structural variant calling (Manta+svimmer+GraphTyper2)
Manta is run in a two step procedure: (1) configuration and (2) workflow execution. More details can be obtained in https://github.com/Illumina/manta/blob/master/docs/userGuide/README.md.

svimmer is used to merge SVs. More details can be obtained in https://github.com/DecodeGenetics/svimmer.

GraphTyper2 is used to genotyping SVs. More details can be obtained in https://github.com/DecodeGenetics/graphtyper.

code including configuration (sbatch/configuration.sbatch), workflow execution (runWorkflow.sbatch), filter (), convert, merge (mergediploidSV.sbatch), genotyping (genotyping_SV.sbatch),concat (concat_SV.sbatch),extract AGGREGATED (extract_AGGREGATED.sbatch),filter SVs >=5Mb (filter_DEL_INS_INV_DUP_AGGREGATED_5Mb.sbatch)
