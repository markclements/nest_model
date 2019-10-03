server<-function(session,input,output){
  
  rv<-reactiveValues()
  
  observeEvent(input$run_sim,{
    
    rv$sim<-nest_sim(10,input$pop_size,input$num_sims) 
    
   })
  
    
  output$nest<-renderPlot({
    validate(
      need(rv$sim, 'Choose input values and run simulation')
    )
      
    
    crossing(x=1:5,y=1:2)%>% 
      mutate(nest_num=1:n()) %>%
      mutate(label=paste0("Nest ",nest_num))->nest_plot
        
    
        nest_plot %>%  
          left_join(.,rv$sim,by="nest_num") %>%
          filter(!is.na(bird_num),sim==input$sim_num)->bird_plot
  
        
        ggplot()+
          geom_point(data = nest_plot,aes(x,y),shape=15,size=40) +
          geom_jitter(data = bird_plot,aes(x,y,color=as_factor(bird_num)),width = 0.16,height = 0.16,size=4)+
          geom_label(data = nest_plot,aes(x,y,label=label),nudge_x = -0.3,nudge_y = 0.4)+
          xlim(0.5,5.5)+
          ylim(0.5,2.5)+
          ggtitle(label=paste0(isolate(input$pop_size)," birds and 10 nests"))+
          theme(legend.position = "none",
                panel.background = element_blank(),
                axis.text = element_blank(),
                axis.ticks = element_blank(),
                axis.title = element_blank(),
                title = element_text(size=20))
          
    
  },height = 300, width = 600)
 
  output$table<-renderDataTable({
    
    validate(
      need(rv$sim, 'Choose input values and run simulation')
    )
    
    rv$sim %>%
      group_by(nest_num,sim) %>%
      count() %>% 
      arrange(sim) %>%
      group_by(sim) %>%
      mutate(nest_occupied=n(),empty_nests=10-nest_occupied) %>%
      mutate(nest_des=case_when(n==1 ~ paste0("# nests with ",n," bird"),
                                TRUE ~ paste0("# nests with ",n," birds")))%>%
      group_by(sim,nest_occupied,empty_nests,nest_des) %>%
      count() %>%
      pivot_wider(names_from = nest_des,values_from = n,values_fill = list(n=0)) %>%
      rename(`Simulation #`=sim,
             `# nests with > 0 birds`=nest_occupied,
             `# nests with 0 birds`=empty_nests)
    
    
  })  
   
  output$table_avg<-renderDataTable({
    
    validate(
      need(rv$sim, 'Choose input values and run simulation')
    )
    
    rv$sim %>%
      group_by(nest_num,sim) %>%
      count() %>% 
      arrange(sim) %>%
      group_by(sim) %>%
      mutate(nest_occupied=n(),empty_nests=10-nest_occupied) %>%
      mutate(nest_des=case_when(n==1 ~ paste0("# nests with ",n," bird"),
                                TRUE ~ paste0("# nests with ",n," birds")))%>%
      group_by(sim,nest_occupied,empty_nests,nest_des) %>%
      count() %>%
      pivot_wider(names_from = nest_des,values_from = n,values_fill = list(n=0)) %>%
      rename(`Simulation #`=sim,
             `# nests with > 0 birds`=nest_occupied,
             `# nests with 0 birds`=empty_nests) %>%
      ungroup() %>%
      summarise_at(vars(-1),~mean(.)) %>%
      rename_all(.,~paste0("mean ",.))
    
    
  })  
  
  
}
  