library(dplyr)
library(ggplot2)
library(shiny)
library(DT)
library(tidyr)
library(devtools)
library(flexdashboard)

ui <- fluidPage(
  
  titlePanel("Best BodyFat Estimator"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput(inputId = "age",label = "Birth Year:", choices = 1980:2010,width="100%"),
      numericInput("weight", "Weight(kg)", value = 0, min = 40, max = 200, width ="60%"),
      numericInput("height", "Height(m)", value = 0, min = 1, max = 2, width ="60%"),
      numericInput("abdomen", "Abdomen 2 circumference(cm)", value = 0, min = 50, max = 200, width ="100%"),
      actionButton("go", "Generate")),
    
    mainPanel(
      column(
        width = 7,
        gaugeOutput("plot1",height=200),
        gaugeOutput("plot2",height=200),
      ),
      column(width = 5, uiOutput('plot3', height = 400)))
  ),hr(),wellPanel(fluidRow(
    column(
      width = 12,
      h4("Information Panel"),textOutput("A"),textOutput("B"),textOutput("C"))
  )))


server <- function(input, output){
  v <- reactiveValues(doPlot = FALSE)
  
  observeEvent(input$go, {
    # 0 will be coerced to FALSE
    # 1+ will be coerced to TRUE
    v$doPlot <- input$go
  })
  
  observeEvent(input$weight, {
    v$doPlot <- FALSE
  })  
  
  output$plot1 = renderGauge({
    if (v$doPlot == FALSE) return()
    else gauge(as.numeric(input$weight)/(as.numeric(input$height))^2, min =0 , max = 50, label = "BMI",sectors = gaugeSectors(success = c(18.5, 24.9), 
                                                                                                                warning = c(13.5, 30),danger = c(0,50)))})
  
  output$plot2 = renderGauge({
    if (v$doPlot == FALSE) return()
    else gauge(-38.873+0.002*(as.numeric(format(Sys.time(), "%Y"))-as.numeric(input$age))+0.838*as.numeric(input$abdomen)-0.245*as.numeric(input$weight), min = 0, max = 50,label = "Bodyfat", sectors = gaugeSectors(success = c(14, 17), warning = c(17, 25),danger = c(0, 50)))})
  
  output$plot3 <- renderUI({
    BMI<-as.numeric(as.numeric(input$weight)/(as.numeric(input$height))^2)
    if (v$doPlot == FALSE) return()
    
    else if (v$doPlot != FALSE & between(BMI,0,8)) img(src='1.jpeg', height = '400px')
    else if (v$doPlot != FALSE & between(BMI,8,14)) img(src='2.jpeg', height = '400px')
    else if (v$doPlot != FALSE & between(BMI,14,22)) img(src='3.jpeg', height = '400px')
    else if (v$doPlot != FALSE & between(BMI,22,30)) img(src='4.jpeg', height = '400px')
    else if (v$doPlot != FALSE & between(BMI,30,100)) img(src='5.jpeg', height = '400px')
    #else print(v$doPlot)
    #else{
      #if (between(BMI,0,8)){img(src='1.jpeg', height = '400px')}
      #if (between(BMI,8,14)){img(src='2.jpeg', height = '400px')}
      #if (between(BMI,14,22)){img(src='3.jpeg', height = '400px')}
      #if (between(BMI,22,30)){img(src='4.jpeg', height = '400px')}
      #if (between(BMI,30,100)){img(src='5.jpeg', height = '400px')}}
  })
  output$A <- renderText({
    #BMI<-as.numeric(as.numeric(input$weight)/(as.numeric(input$height))^2)
    #if (between(BMI,8,20)) print(BMI)
    #else print(BMI)
    print("Weight and Height Measurement Remark: Weight input is in Kilogram and Height input is in Meter")
  })
  
  output$B <- renderText({
    print("Abdomen 2 Measurement Remark: Laterally, at the level of the iliac crests, and anteriorly, at the umbilicus. Input in centimeter")
  })
  output$C <- renderText({
    print("Contact: If you have any questions in terms of this shiny app, please contant sliu736@wisc.edu;hchen727@wisc.edu;wang2688@wisc.edu;mzheng54@wisc.edu;")
    
  })
}
shinyApp(ui, server)