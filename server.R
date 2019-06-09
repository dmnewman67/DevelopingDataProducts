library(shiny)
library(datasets)

mpgData <- mtcars

shinyServer(function(input, output) {
  
  output$fit <- renderPrint({summary(fit())})
  
  labelText <- reactive({paste("mpg ~", input$variable)})
  
  fit <- reactive({lm(as.formula(labelText()), data=mpgData)})
  
  output$caption <- renderText({labelText()})
  
  output$boxPlot <- renderPlot({boxplot(as.formula(labelText()), data = mpgData)})
  
  output$dotPlot <- renderPlot({with(mpgData, {
    plot(as.formula(labelText()))
    abline(fit(), col=2)})
  })
  
})