# Snakefile
rule all:
    input:
        "visualisation/ggplot1.png",
        "visualisation/ggplot2.png"


input_files = ["raw/BMI.csv", "raw/DEMO_D.csv","raw/FFQRAW_D.csv"]


# Rule to clean the data
rule clean_data:
    input:
        input_files
    output: 
        "clean/finaldata.csv"
    script:
        "code/explore_and_transform.R"


# Rule to produce plots
rule produce_plots:
    input:
        "clean/finaldata.csv"
    output:
        "visualisation/ggplot1.png",
        "visualisation/ggplot2.png"
    script:
        "code/plot.R"

