library(shiny)

ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "xAxis","Choose x axis:",
                        choices = c("mpg","disp","hp","wt")),
            selectInput(inputId = "yAxis","Choose y axis:",
                        choices = c("wt","drat","hp","disp")),
            sliderInput("pch", "Integer:",
                        min = 1, max = 22,
                        value = 1),
#            selectInput(inputId = "pch","Choose shape:",
#                        choices = c("circle"=1,"circle2"=16,"square"=22)),
           sliderInput(inputId = "cex","point size",
                        min=0.1, max=3, value=1)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput(outputId = "mtcarsPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$mtcarsPlot <- renderPlot({
        title <- paste(input$xAxis , " VS ",input$yAxis)
        plot(mtcars[,c(input$xAxis,input$yAxis)],
             main=title,
             pch=as.numeric(input$pch),
             cex=input$cex )
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
