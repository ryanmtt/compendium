# Visualisation code 

# load in transformed and cleaned data:
library(dplyr)
library(ggplot2)
library(mfp)
library(haven)
library(tidyverse)
library(hexbin)

subset_data <- read.csv("clean/finaldata.csv")

# model:

subset_dataf <- subset(subset_data,fruit>0)


# could add in some covariates !!!! (and remove non-used ones form the dataset!)

## ggplot #1:

fig1=ggplot(data = subset_dataf, mapping = aes(x = fruit, y = BMXBMI)) +
  geom_hex(na.rm = TRUE, bins = 70) +
  scale_fill_distiller()+ geom_smooth(
    method = "loess",
    colour = "#F7DD70",
    formula = "y~log(x)",
    na.rm = TRUE
  )+ scale_x_continuous(trans = "log")+ylim(c(10,60))  +labs(
    x = "Yearly Fruit Consumption on the log scale",
    y = "Body Mass Index (BMI)",
    title = "Body Mass Index by Fruit Consumption in the NHANES dataset") +theme_bw()


# interpt by change in y as  p% change in x -> log((100+p)/100)*coeff

fig1 %>% ggsave(filename="visualisation/ggplot1.png",plot=.)


# ggplot #2:

subset_data$bmi_cat <- cut(subset_data$BMXBMI, breaks = c(0,18.5,25,30,200), labels = c("Underweight", "Normal Weight", "Overweight","Obese"))
fig2 <- ggplot(subset_data, aes(x = bmi_cat, y = fruit/52)) +
  geom_boxplot() +
  labs(title = "Boxplot of fruit consumption by BMI category",
       x = "BMI Category",
       y = "Weekly fruit consumption") +
  theme_minimal()+ylim(c(0,25))

fig2 %>% ggsave(filename="visualisation/ggplot2.png",plot=.)

