side_area_plot = function(data, cat, reg){
  
  unit = if_else(cat == "prod", "Thousand Ton", "Thousand HA")
  
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
    e_bar(`Sweet Potato`, stack = "g1") %>% 
    e_legend_unselect("Cereal") %>% 
    e_legend_unselect("Paddy") %>% 
    e_legend_unselect("Maize") %>% 
    e_legend_unselect("Sweet Potato") %>% 
    e_title(subtext = paste0("Unit: ", unit)) %>% 
    e_tooltip() %>% 
    e_show_loading()
}
# side_area_plot(agri, "area", "Nghe An")
