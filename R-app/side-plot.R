side_plot = function(data, cat, region){
  data %>% 
    filter(region == .env$region,
           str_detect(category, .env$cat)) %>% 
    mutate(category = fct_reorder(category, value)) %>% 
    arrange(desc(category)) %>% 
    group_by(year) %>% 
    e_chart(category, timeline = TRUE) %>%
    e_bar(value)
  
}

#side_plot(agri, "prod", "Ninh Binh")




