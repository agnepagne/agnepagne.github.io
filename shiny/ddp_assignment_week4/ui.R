library(shiny)

# Check https://shiny.rstudio.com/articles/action-buttons.html

shinyUI(
  fluidPage(
    titlePanel("A couple of silly games"),

    mainPanel(
      tabsetPanel(
        # Information about the games
        tabPanel(title = "Info"),
        
        # Sharea - guess what proportion of the area is black
        tabPanel(title = "Play Sharea",
                 fluidRow(
                   column(sliderInput("sharea_cols",
                                      "Horizontal tiles",
                                      min = 15,
                                      max = 200,
                                      value = 100), width = 4 ),
                   column(sliderInput("sharea_rows",
                                      "Vertical tiles",
                                      min = 15,
                                      max = 200,
                                      value = 100), width = 4)),
                 actionButton("sharea_go", "Go!"),
                 plotOutput("sharea_plot"),
                 numericInput("sharea_guess", "How much of the area is black?", NULL),
                 textOutput("sharea_res") #Hide until user guesses!
        ),

        # Correlate - guess the correlation between X and Y
        tabPanel(title = "Play Correctelate",
                 sliderInput("cor_n",
                             "Number of data points",
                             min = 10,
                             max = 200,
                             value = 50),
                 actionButton("cor_go", "Go!"),
                 plotOutput("cor_plot"),
                 numericInput("cor_guess", "Guess the correlation (between -1 and +1)", NULL),
                 textOutput("cor_res") #Hide until user guesses!
        )
      )
    )
  )
)
