nest_sim<-function(n_nests,pop_size){
  selection<-sample(1:n_nests,size=pop_size,replace=T)
  tibble(nest_num=selection) %>% mutate(bird_num=1:n()) 
}
