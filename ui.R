ui<-fluidPage(
      column(width=2,
          numericInput(inputId="pop_size",
                       label = p("Population Size"),
                       min = 1, 
                       max=10,
                       value=1,
                       step = 1),
          actionButton(inputId="run_sim",label="Run Simulation")
            ),
      column(width=10,
          p("plot here"),       
          plotOutput("nest")
        )
  )

  
  