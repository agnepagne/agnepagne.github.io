library(shiny)

shinyServer(function(input, output) {

  # Sharea "Go" button pressed, randomize new image
  observeEvent(
    input$sharea_go,
    {
      cols <- input$sharea_cols
      rows <- input$sharea_rows
      p <- runif(1, 0.01, 0.99)
      m <- matrix(as.numeric(rbinom(cols*rows, 1, p)), cols, rows)
      output$sharea_plot <- renderPlot({
        image(m, col = c("white", "black"), axes = F)
      })
      # To fix - user will have to guess share and then compare to result
      output$sharea_res <- renderText( mean(m) )
    }
  )

  # Correlctelate "Go" button pressed, randomize new plot
  observeEvent(
    input$cor_go,
    {
      n <- input$cor_n
      xmin <- 0
      xmax <- 100
      x <- runif(n, xmin, xmax)
      
      b <- sample(c(-1, 1), 1)
      s <- runif(1, xmin, xmax)
      y <- b*x + rnorm(n, 0, s)

      output$cor_plot <- renderPlot({plot(x, y, axes = F)})
      output$cor_res <- renderText( cor(x, y) )
    }
  )
})
