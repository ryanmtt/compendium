# Visualisation code 

# load in transformed and cleaned data:

subset_data <- read.csv("../clean/finaldata.csv")


# model:

subset_dataf <- subset(subset_data,fruit>0)

fitf=mfp(BMXBMI~fp(fruit,df=4,select=0.05),family=gaussian,data=subset_dataf,verbose=TRUE)
subset_dataf$predict <- predict(fitf)

# could add in some covariates !! (and remove non-used ones form the dataset!)



## ggplot #1:

ggplot(data = subset_dataf, mapping = aes(x = fruit/52, y = BMXBMI)) +
  geom_hex(na.rm = TRUE, bins = 70) +
  scale_fill_distiller()+ geom_smooth(
    method = "loess",
    colour = "#F7DD70",
    formula = "y~log(x)",
    na.rm = TRUE
  )+ scale_x_continuous(trans = "log")+ylim(c(10,60))  +labs(
    x = "Weekly Fruit Consumption on the log scale",
    y = "Body Mass Index (BMI)",
    title = "Body Mass Index by Fruit Consumption in the NHANES dataset") +theme_bw()

# save this as a png somehow in the results file in compendium !!       

# interpt by change in y as  p% change in x -> log((100+p)/100)*coeff


# ggplot #2:

subset_data$bmi_cat <- cut(subset_data$BMXBMI, breaks = c(0,18.5,25,30,200), labels = c("Underweight", "Normal Weight", "Overweight","Obese"))
ggplot(subset_data, aes(x = bmi_cat, y = fruit/52)) +
  geom_boxplot() +
  labs(title = "Boxplot of fruit consumption by BMI category",
       x = "BMI Category",
       y = "Weekly fruit consumption") +
  theme_minimal()+ylim(c(0,25))


# commments 