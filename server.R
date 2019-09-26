server<-function(session,input,output){
  
  output$nest<-renderPlot({
      
    input$run_sim
    
        crossing(x=1:2,y=1:5)%>% 
          mutate(nest_num=1:n())->nest_plot
        
        nest_plot %>%  
          left_join(.,nest_sim(10,isolate(input$pop_size)),by="nest_num") %>%
          filter(!is.na(bird_num))->bird_plot
        
        
        ggplot()+
          geom_point(data = nest_plot,aes(x,y),shape=15,size=27) +
          geom_jitter(data = bird_plot,aes(x,y,color=as_factor(bird_num)),width = 0.1,height = 0.1,size=5)+
          xlim(0.5,2.5)+
          ylim(0.5,5.5)
  })
  
}
  