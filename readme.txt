# Welcome to this research compendium investigating the association between fruit consumption and BMI of individuals

# Firstly, ensure you have the correct environment according that outlined in the environment.yml file


# 1. OUTLINING THE DATASET AND VARIABLES:

# Use subset of the NHANES dataset, combining data from BMI, DEMO_D and FFQ_RAW datasets according to sequence number 
# data taken from here - https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=Examination&CycleBeginYear=2005
# https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=Demographics&CycleBeginYear=2005
# https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=Dietary&Cycle=2005-2006
# and externally converted to csv files inside "/raw" subdirectory 
# Dataset is referred to by subset_dataf throughout the code. Includes information on 5441 individuals
# 4 main variables are focused on in this dataset:
# "BMXBMI", which tracks BMI of individuals
# "fruit" variable is created from taking the FFQ variables for fruit in the NHANES data set and taking mean values of
# consumption of different fruits to get an approximation of individuals consumption across a whole year. Specifics of
# how this is calculated are outlined in the "explore_and_transform.R" file 
# Created a binary variable on income, which specifies "high" income to be those
# with income >twice that of the poverty line. And anything below this threshold is considered "low". Also included a
# binary variable on gender, where TRUE denotes female



# 2. RUNNING THE CODE:

# use snakemake and the Snakefile to run the 2 R files in "/code" to produce both the cleaned data set, 
# "finaldata.csv" and the two ggplots, "ggplot1.png" and "ggplot2.png"
# Shiny app can be accessed inside the visualisation subdirectory and then ran to get an interactive shiny plot 



