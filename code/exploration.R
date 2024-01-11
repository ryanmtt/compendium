# Cleaning the data

library("tidyverse")

setwd('//wsl.localhost/Ubuntu/home/compendium')


INPUT_FILE_BMI <- "raw/BMI.csv"
INPUT_FILE_DEMO <- "raw/DEMO_D.csv"
INPUT_FILE_FFQ <- "raw/FFQRAW_D.csv"

# check files exist:

data_dir_exists = fs::dir_exists("raw")
data_file_exists1 = fs::file_exists(INPUT_FILE_BMI)
data_file_exists2 = fs::file_exists(INPUT_FILE_DEMO)
data_file_exists3 = fs::file_exists(INPUT_FILE_FFQ)
print(glue::glue("Current working directory: {getwd()}"))
print(glue::glue("{INPUT_FILE_BMI} exsits: {data_file_exists1}"))
print(glue::glue("{INPUT_FILE_DEMO} exsits: {data_file_exists2}"))
print(glue::glue("{INPUT_FILE_FFQ} exsits: {data_file_exists3}"))

# load the dataset into R:

BMI_RAW <- read.csv(INPUT_FILE_BMI)
DEMO_RAW <- read.csv(INPUT_FILE_DEMO)
FFQ_RAW <- read.csv(INPUT_FILE_FFQ)

glimpse(BMI_RAW)
glimpse(DEMO_RAW)
glimpse(FFQ_RAW)

# Basic Exploration:


