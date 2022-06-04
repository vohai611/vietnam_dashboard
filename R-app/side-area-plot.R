side_area_plot = function(data, cat, reg){
  
  data %>% 
    filter(! region %in% .env$region) %>% 
    filter(region == {{ reg }} ) %>% 
    filter(str_detect(category, .env$cat)) %>% 
    mutate(category = case_when(
      str_detect(category, "cereal") ~ "Cereal",
      str_detect(category, "paddy") ~ "Paddy",
      str_detect(category, "maize") ~ "Maize",
      str_detect(category, "sw_potato") ~ "Sweet Potato"
    )) %>% 
    tidyr::pivot_wider(names_from = category, values_from = value) %>% 
    e_chart(year) %>% 
    e_bar(Cereal, stack = "g1") %>% 
    e_bar(Paddy, stack = "g1") %>% 
    e_bar(Maize, stack = "g1") %>% 
    e_bar(`Sweet Potato`, stack = "g1")
}
# side_area_plot(agri, "area", "Nghe An")
