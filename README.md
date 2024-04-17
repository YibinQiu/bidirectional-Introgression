# bidirectional-Introgression
# 1.Read mapping and Variant calling
gatk best practices workflow can be obtained in https://github.com/qgg-lab/swim-public.
# 2.Structural variant calling (Manta+svimmer+GraphTyper2)
Manta is run in a two step procedure: (1) configuration and (2) workflow execution. More details can be obtained in https://github.com/Illumina/manta/blob/master/docs/userGuide/README.md.

svimmer is used to merge SVs. More details can be obtained in https://github.com/DecodeGenetics/svimmer.

GraphTyper2 is used to genotyping SVs. More details can be obtained in https://github.com/DecodeGenetics/graphtyper.

code including configuration (sbatch/configuration.sbatch), workflow execution (runWorkflow.sbatch), filter (), convert, merge (mergediploidSV.sbatch), genotyping (genotyping_SV.sbatch),concat (concat_SV.sbatch),extract AGGREGATED (extract_AGGREGATED.sbatch),filter SVs >=5Mb (filter_DEL_INS_INV_DUP_AGGREGATED_5Mb.sbatch)

# 3.Functional annotation of SVs
Working on organizing the code that needs to be uploaded....
# 4.Genetic diversity statistics
Working on organizing the code that needs to be uploaded....
# 5.Population structure and phylogenetic analysis
Working on organizing the code that needs to be uploaded....
# 6.Gene flow among populations
Working on organizing the code that needs to be uploaded
# 7.Identification of introgressed genomic regions
Working on organizing the code that needs to be uploaded
# 8.Identification of population-specific and introgressed SVs
Working on organizing the code that needs to be uploaded
# 9.Analysis of BMP2 haplotype pattern and network
Working on organizing the code that needs to be uploaded
# 10.Genome-wide association study
Working on organizing the code that needs to be uploaded
# 11.Functional enrichment analysis
Working on organizing the code that needs to be uploaded
