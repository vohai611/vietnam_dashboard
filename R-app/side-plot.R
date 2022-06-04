side_plot = function(data, cat, region, title){
  data %>% 
    filter(region == .env$region,
           str_detect(category, .env$cat)) %>% 
    mutate(category = fct_reorder(category, value)) %>% 
    arrange(desc(category)) %>% 
    group_by(year) %>% 
    e_chart(category, timeline = TRUE) %>%
    e_bar(value) %>% 
    e_title(text = title,
            subtext = "From 1995-2020") %>% 
    e_timeline_opts(
      play_interval = "50",
      top = 10,
      right = 50,
      left =200
    ) %>% 
    e_tooltip() %>% 
    e_legend(show = FALSE)
  
  
}

#side_plot(agri, "prod", "Ninh Binh")




