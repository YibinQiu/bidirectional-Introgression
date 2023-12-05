# bidirectional-Introgression
1.Read mapping and Variant calling
gatk best practices workflow can be obtained in https://github.com/qgg-lab/swim-public.
2.Structural variant calling (Manta+svimmer+GraphTyper2)
Manta is run in a two step procedure: (1) configuration and (2) workflow execution. The configuration step is used to specify the input data and any options pertaining to the variant calling methods themselves. The execution step is used to specify any parameters pertaining to how manta is executed (such as the total number of cores or SGE nodes over which the jobs should be parallelized). The second execution step can also be interrupted and restarted without changing the final result of the workflow.
