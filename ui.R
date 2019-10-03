ui<-fluidPage(
      column(width=3,
          sliderInput(inputId="pop_size",
                       label = p("Birds searching for nest"),
                       min = 1, 
                       max=10,
                       value=1,
                       step = 1),
          sliderInput(inputId="num_sims",
                      label = "Number of simulations",
                      min=1,
                      max=100,
                      step=1,
                      value=10),
          actionButton(inputId="run_sim",label="Run Simulation")
            ),
      column(width=9,
        tabsetPanel(
        tabPanel(title="Nest search results", 
          numericInput(inputId="sim_num",
                       label = "View result from simulation #",
                       min=1,
                       max=100,
                       step=1,
                       value=1,
                       width = "100%"),       
          plotOutput("nest",height=200,width = "100%")
        ),
        tabPanel(title="Summary table",
            dataTableOutput("table")
        ),
        tabPanel(title="Summary table (averages)",
            dataTableOutput("table_avg"))
      )
  )
)
  
  