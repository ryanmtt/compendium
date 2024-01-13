# Load libraries
library(shiny)
library(ggplot2)
library(dplyr)

# Define UI

subset_dataf$Income=as.logical(subset_dataf$INCBIN)
subset_dataf$Gender=as.logical((subset_dataf$RIAGENDR)-1)
subset_dataoutput=data.frame(subset_dataf[,c(2,13,14,15)])


ui <- fluidPage(
  titlePanel("Plot of Fruit Consumption against BMI by Income or Gender"),
  sidebarLayout(
    sidebarPanel(
      selectInput("covariate", "Select Binary Covariate", choices = colnames(subset_dataf)[sapply(subset_dataf, is.logical)] )
    ),
    mainPanel(
      plotOutput("regressionPlot"),
      h3("First 6 entries in the cleaned data set"),
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
        x = "Weekly Fruit Consumption",
        y = "BMI, logged axis",
        color = input$covariate) + scale_color_manual(values = c("FALSE" = "blue", "TRUE" = "red"),labels = c("Male / Low Income", "Female / High Income"))+scale_y_continuous()+xlim(0,50)+scale_y_continuous(trans = "log",limits=c(10,50))+
      theme_minimal()
  })
  

  output$table <- renderTable({
    head(subset_dataoutput)
  })
  
  
}




# Run the application
shinyApp(ui = ui, server = server)