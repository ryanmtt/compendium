# Cleaning the data


library("tidyverse")

library(dplyr)



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
data1 <- inner_join(BMI_RAW, DEMO_RAW, by = "SEQN")
data <- inner_join(data1, FFQ_RAW, by = "SEQN")
dim(data)

# Transform the data further for analysis/ plotting:

# We decide to analyse the assocation between the amount of fruit
# consumed and BMI of individuals in the NHANES dataset
# and so clean and transform the data as so:


# we remove missing observations
subset_data<-data[data$FFQ0016<12 & data$FFQ0017<12 & data$FFQ0018<12 & data$FFQ0019<12 & data$FFQ0020<12 & data$FFQ0022<12 & data$FFQ0027<12,]
subset_data <- subset_data %>%
  filter(!is.na(!!sym("BMXBMI")))

vec=c(0,mean(c(1,6)),mean(c(7,11)),12,mean(c(24,36)),52,104,mean(c(156,208)),mean(c(260,312)),365,730)

subset_data <- subset(subset_data, select = -c(FFQ0021, FFQ0021A,FFQ0021B,FFQ0023,FFQ0023A,FFQ0023B,FFQ0024,FFQ0024A,FFQ0024B,FFQ0025,FFQ0025A,FFQ0025B,FFQ0026,FFQ0026A,FFQ0026B))


which(colnames(subset_data) == "FFQ0016")
which(colnames(subset_data) == "FFQ0027")


for(i in 77:83)
{
  subset_data[,i]=as.factor(subset_data[,i])
}

l_mapping <- list(FFQ0016= c('1' = "0", '2' = "3.5", '3' = "9",'4' = "12" ,'5' = "30",'6' = "52",'7' = "104",'8' = "182" ,'9' = "286",'10' = "365", '11' = "730"),FFQ0017= c('1' = "0", '2' = "3.5", '3' = "9",'4' = "12" ,'5' = "30",'6' = "52",'7' = "104",'8' = "182" ,'9' = "286",'10' = "365", '11' = "730"),
                  FFQ0018= c('1' = "0", '2' = "3.5", '3' = "9",'4' = "12" ,'5' = "30",'6' = "52",'7' = "104",'8' = "182" ,'9' = "286",'10' = "365", '11' = "730"), FFQ0019= c('1' = "0", '2' = "3.5", '3' = "9",'4' = "12" ,'5' = "30",'6' = "52",'7' = "104",'8' = "182" ,'9' = "286",'10' = "365", '11' = "730"),
                  FFQ0020= c('1' = "0", '2' = "3.5", '3' = "9",'4' = "12" ,'5' = "30",'6' = "52",'7' = "104",'8' = "182" ,'9' = "286",'10' = "365", '11' = "730"), FFQ0022= c('1' = "0", '2' = "3.5", '3' = "9",'4' = "12" ,'5' = "30",'6' = "52",'7' = "104",'8' = "182" ,'9' = "286",'10' = "365", '11' = "730"),
                  FFQ0027= c('1' = "0", '2' = "3.5", '3' = "9",'4' = "12" ,'5' = "30",'6' = "52",'7' = "104",'8' = "182" ,'9' = "286",'10' = "365", '11' = "730"))

col_to_revalue=colnames(subset_data[,77:83])


for (col in col_to_revalue) {
  subset_data[[col]] <- dplyr::recode(subset_data[[col]], !!!l_mapping[[col]])
}

subset_data <- subset_data %>%
  mutate(across(all_of(col_to_revalue), as.numeric))

for(i in 77:83)
{
  subset_data[,i]=as.numeric(gsub("\"", "", as.character(subset_data[,i])))
}

subset_data$fruit <- rowSums(subset_data[,c(col_to_revalue)])


# subset(subset_data, select = -c(# col names of ones i want to remove)


# save this subset_dataf in the clean directory in compendium
subset_data %>% write_csv("clean/finaldata.csv")