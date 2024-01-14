# Load libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(rsconnect)

# Define UI
setwd("../")
subset_data <- read.csv("clean/finaldata.csv")

# model:

subset_dataf <- subset(subset_data,fruit>0)
subset_dataf$Income=as.logical(subset_dataf$INCBIN)
subset_dataf$Gender=as.logical((subset_dataf$RIAGENDR)-1)
subset_dataf$BMI=subset_dataf$BMXBMI
subset_dataf$Weekly_fruit=(subset_dataf$fruit)/52




ui <- fluidPage(
  titlePanel("Plot of Fruit Consumption against BMI by Income or Gender"),
  sidebarLayout(
    sidebarPanel(
      selectInput("covariate", "Select Binary Covariate", choices = colnames(subset_dataf)[sapply(subset_dataf, is.logical)] )
    ),
    mainPanel(
      plotOutput("regressionPlot"),
      h3("Last 6 entries in the cleaned data set:"),
      tableOutput("table")
    )
  )
)

# Define server logic
 server <- function(input, output) {
  
  # Reactive function to perform linear regression
  lm_model <- reactive({
    formula <- paste("BMXBMI ~ I(log(fruit)) + ", input$covariate)
    formula <- as.formula(formula)
    lm(formula, data = subset_dataf)
  })
  
  # Reactive function to get fitted values
  fitted_values <- reactive({
    predict(lm_model())
  })
  
  # Render the plot
  output$regressionPlot <- renderPlot({
    ggplot(subset_dataf, aes(x = fruit/52, y = BMXBMI, color = factor(get(input$covariate)))) + geom_point(alpha = 0.3)+geom_line(aes(y=fitted_values()),size=1.5)+
      labs(
        title = paste("Fruit Consumption against BMI by",input$covariate),
        x = "Weekly Fruit Consumption, logged axis",
        y = "BMI",
        color = input$covariate) + scale_color_manual(values = c("FALSE" = "blue", "TRUE" = "red"),labels = c("Male / Low Income", "Female / High Income"))+scale_y_continuous(limits=c(10,42))+xlim(0,55)+scale_x_continuous(trans = "log",limits=c(1,100))+
      theme_minimal()
  })
  

  output$table <- renderTable({
    subset_dataf$Gender <- factor(subset_dataf$Gender, levels = c(FALSE, TRUE), labels = c("Male", "Female"))
    subset_dataf$Income <- factor(subset_dataf$Income, levels = c(FALSE, TRUE), labels = c("Low", "High"))
    subset_dataoutput=data.frame(subset_dataf[,c(14,15,16,17)])
    tail(subset_dataoutput)
  })
  
  
}




# Run the application
shinyApp(ui = ui, server = server)
