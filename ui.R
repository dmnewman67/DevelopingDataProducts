library(shiny)

shinyUI(
  navbarPage("Developing Data Products",
            tabPanel("Comparitive Analysis",
                      fluidPage(
                        titlePanel("Fuel Economy (mpg) by Engine characteristic"),
                          
                            selectInput("variable", "Select Engine Characteristic:",
                                        c("Cylinders" = "cyl",
                                          "Displacement" = "disp",
                                          "Horsepower" = "hp"
                                        )),
                            
                            
                            tabsetPanel(type = "tabs", 
                                        tabPanel("Plots", 
                                                 h2(textOutput("caption")),
                                                 plotOutput("boxPlot"),
                                                 plotOutput("dotPlot")),
                                        tabPanel("Regression Details", 
                                                 verbatimTextOutput("fit")
                                        )
                            )
                      )
             ),
             tabPanel("Server Code",
                      code("mpgData <- mtcars"),
                      br(),
                      code("shinyServer(function(input, output) {"),
                      br(),
                      code("output$regFit <- renderPrint({summary(regFit())})"),
                      br(),
                      code("labelText <- reactive({paste('mpg ~', input$variable)})"),
                      br(),
                      code("regFit <- reactive({lm(as.formula(labelText()), data=mpgData)})"),
                      br(),
                      code("output$label <- renderText({labelText()})"),
                      br(),
                      code("output$boxPlot <- renderPlot({boxplot(as.formula(labelText()), data = mpgData)})"),
                      br(),
                      code("output$dotPlot <- renderPlot({with(mpgData, {plot(as.formula(labelText()))abline(fit(), col=2)})})"),
                      br(),
                      code("})")

                     
                     
             )
  )
)