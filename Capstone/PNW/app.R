
library(shiny)
ngram_models_final <- readRDS("data/ngram_models.rds")
source("predictv4.R")

# Define UI ----
ui <- fluidPage(
 titlePanel("Next word prediction"),

fluidRow(
  column(6, offset = 3,
        h3("Input:"),
        h4("Enter your text here and click the Predict button when done"),textInput("text",  
              h3(" "),
              value = "data science is cool"),
              submitButton("Predict"))),
hr(),
fluidRow(
  column(6, offset = 3,
        h3("Output:"),
        h4("The next word prediction algorithm will return upto 3 options"),
        h4("If the next word prediction algorithm comes up empty then ? is returned "),
        h4(" "),
        h4("Next word option(s):"),
        tableOutput("predictions")
)
 )
)
# Define server logic ----
server <- function(input, output) {
  output$predictions <- renderTable({ 
    predict_next_word(input$text,ngram_models_final)
  })
}
# Run the app ----
shinyApp(ui = ui, server = server)