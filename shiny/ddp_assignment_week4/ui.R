library(shiny)

# Check https://shiny.rstudio.com/articles/action-buttons.html

correctelate_info <-
"In Correctelate, you have to guess the correlation between X and Y. First, use the slider to select how many data points you want to see (or just leave it at default). Click Go, and a scatterplot will show up. Now, enter your guessed correlation (between -1.00 and +1.00) in the box below the scatterplot. When you are done guessing, click Guess and see how close you were." 

sharea_info <- "In Sharea, you have to guess what proportion of the given area is black. First, use the sliders to select how many tiles you want to see (or just leave it at default). The total number of tiles will be vertical times horizontal. Click go, and a number of black and white tiles will show up. Now, enter your guessed proportion of black tiles (between 0.00 and 1.00) in the box below the tiles. When you are done guessing, click Guess and see how close you were."

shinyUI(
    fluidPage(
    titlePanel("A couple of silly games"),

    mainPanel(
      tabsetPanel(
        # Information about the games
        tabPanel(title = "Info",
                 h3("Correctelate"),
                 p(correctelate_info),
                 h3("Sharea"),
                 p(sharea_info)
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
                 numericInput("cor_user",
                              "Guess the correlation",
                              value = NULL,
                              min = -1.00,
                              max = 1.00,
                              step = 0.01),
                 actionButton("cor_guess", "Guess"),
                 textOutput("cor_res")
        ),
        
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
                 numericInput("sharea_user",
                              "How much of the area is black? (0.00-1.00)",
                              value = NULL,
                              min = 0.00,
                              max = 1.00,
                              step = 0.01),
                 actionButton("sharea_guess", "Guess"),
                 textOutput("sharea_res")
        )
      )
    )
  )
)
