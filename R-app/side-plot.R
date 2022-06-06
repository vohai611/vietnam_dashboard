side_plot = function(data, cat, region, title, year ){
  data %>% 
    filter(region == .env$region,
           year == .env$year,
           str_detect(category, .env$cat)) %>% 
    mutate(category = case_when(
      str_detect(category, "cereal") ~ "Cereal",
      str_detect(category, "paddy") ~ "Paddy",
      str_detect(category, "maize") ~ "Maize",
      str_detect(category, "sw_potato") ~ "Sweet Potato"
    )) %>% 
    mutate(category = fct_relevel(category, c("Cereal", "Paddy", "Maize", "Sweet Potato"))) %>% 
    arrange(category) %>% 
    e_chart(category) %>%
    e_pie(value, radius = c("50%", "70%"),
          label = list(formatter = "{b} : {d}%")) %>% 
    e_tooltip() %>% 
    e_legend(show = FALSE) %>% 
    e_title(text = title,
            subtext = paste0("In ", year), subtextStyle= list(color = "red") )
  
}

#side_plot(agri, "prod", "Ninh Binh",title = 'abc', year = 2019)

