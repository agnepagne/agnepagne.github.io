library(shiny)

shinyServer(function(input, output) {

  # Display message depending on how close the guess was
  howclose <- c("great!!", "good", "OK", "pretty bad", "very bad", "awful!")
  mean_obs <- NULL
  cor_obs <- NULL
  
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
        box()
      })
      mean_obs <<- round(mean(m), 2)
    }
  )
  
  # Sharea "Guess" button pressed, present result
  observeEvent(
    input$sharea_guess,
    {
      if( is.null(mean_obs)||is.null(input$sharea_user) ){
        return(NULL)
      }
      suser <- round(input$sharea_user, 2)
      s_res <- paste("Your guess was:",
                     suser,
                     "- Correct answer: ",
                     mean_obs,
                     "That was...",
                     howclose[1 + min(5, round(10*abs(mean_obs - suser)))]
      )
      output$sharea_res <- renderText( s_res )
    }
  )
  
  # Correctelate "Go" button pressed, randomize new plot
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
      cor_obs <<- round(cor(x, y), 2)
    }
  )

  # Correlate "Guess" button pressed, present result
  observeEvent(
    input$cor_guess,
    {
      if( is.null(cor_obs)||is.null(input$cor_user) ){
        return(NULL)
      }
      cuser <- round(input$cor_user, 2)
      c_res <- paste("Your guess was:",
                     cuser,
                     "- Correct answer: ",
                     cor_obs,
                     "That was...",
                     howclose[1 + min(5, round(10*abs(cor_obs - cuser)))]
      )
      output$cor_res <- renderText( c_res )
    }
  )
})
