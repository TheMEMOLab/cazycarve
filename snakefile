__author__ = "Carl Mathias Kobel"
__maintainter__ = "https://github.com/cmkobel/snakemake_template"

print("""Description:
    May the data passing through this pipeline
    somehow help to bring just a little more peace
    in this troubled world.
""")
    

#  snakemake --profile profiles/local



rule all:
    input: "path/to/output.txt"
    input: "path/to/failed_output.txt"
    


rule generator:
    output: touch("path/to/output.txt")
    # conda: "conda_definitions/some_software.yaml"
    # threads: 1
    # resources: 
    #     mem_mb = 1024,
    #     runtime = "720m",
    shell: """

        touch {output}
        
    """


# You can delete this if you're done testing the behaviour of log_handler_script.py
rule fail_tester:
    output: touch("path/to/failed_output.txt")
    #conda: "conda_definitions/some_software.yaml"
    # threads: 1
    # resources: 
    #	mem_mb = 1024,
    #	runtime = "12:00:00",
    resources:
        runtime = "6m"
    shell: """
    
        echo "errorr"
        >&2 echo "About to fail ..."
        exit 1
        
    """





onstart: 
    shell("mkdir -p logs/old/; mv logs/*.log logs/old/ 2> /dev/null || exit 0") # Put old logs aside
    shell("find output/ > .onstart.txt 2> /dev/null || exit 0")

onsuccess:
    print("onsuccess: The following files were created:")
    shell("find output/ > .onsuccess.txt && diff .onstart.txt .onsuccess.txt || exit 0")

