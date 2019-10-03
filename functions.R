nest_sim<-function(n_nests,pop_size,num_sims){
  
  
  map_dfr(1:num_sims,~{
  selection<-sample(1:n_nests,size=pop_size,replace=T)
  tibble(nest_num=selection) %>% 
    mutate(bird_num=1:n(),
           sim=.x)
  })
}


