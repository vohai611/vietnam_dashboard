side_plot = function(data, cat, region, title, year ){
  data %>% 
    filter(region == .env$region,
           year == .env$year,
           str_detect(category, .env$cat)) %>% 
    mutate(category = fct_reorder(category, value)) %>% 
    arrange(desc(category)) %>% 
    e_chart(category) %>%
    e_pie(value, radius = c("50%", "70%")) %>% 
    e_tooltip() %>% 
    e_legend(show = FALSE) %>% 
    e_title(text = title)
  
}

#side_plot(agri, "prod", "Ninh Binh",title = 'abc', year = 2019)




