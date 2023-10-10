#  snakemake --profile profiles/local

# May the data passing through this pipeline
# somehow help to bring just a little more peace
# in this troubled world.


__author__ = "Ove Øyås & Carl Mathias Kobel"

    


rule all:
    input: "path/to/output.txt"
    input: "path/to/failed_output.txt"
    

# How do we package the databases? Depends on their licenses.


rule diamond:
    output: touch("path/to/output.txt")
    conda: "conda_definitions/diamond.yaml"
    # threads: 1
    # resources: 
    #     mem_mb = 1024,
    #     runtime = "720m",
    shell: """

        touch {output}
        
    """
