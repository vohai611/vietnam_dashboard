library(echarts4r)

draw_viet_map =  function(data,cat, prod) {
  data %>%
    filter(!region %in% .env$region) %>% 
    filter(str_detect(category, prod),
           str_detect(category, cat)) %>% 
    e_chart(region) %>%
    e_map_register('vn', haitools::small_vnjson) %>%
    e_map(value, map = 'vn',
          roam = "move",
          left = "90%",
          right = "90%"
        #  label = list(show = FALSE, position = "left"),
) %>%
    e_visual_map(value) %>%
   # e_legend(FALSE) %>% 
    e_tooltip() %>% 
    #e_theme("sakura") %>% 
    e_show_loading()
}
 agri %>% filter(year == "2019") %>% 
 draw_viet_map(cat = "prod",prod = "cereal")

 