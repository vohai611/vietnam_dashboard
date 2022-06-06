small_vnjson = readRDS(here("data/small_vnjson.rds"))

draw_viet_map =  function(data,cat, prod, region_selected) {
  data %>%
    filter(!region %in% .env$region) %>% 
    filter(str_detect(category, prod),
           str_detect(category, cat)) %>% 
    e_chart(region) %>%
    e_map_register('vn', small_vnjson ) %>%
    e_map(value, map = 'vn',
          roam = "move",
          zoom = 1.2,
          itemStyle = list(areaColor ="#fac858",
                           borderWidth = .2,
                           borderColor = "#272727"),
          select = list(itemStyle = list(areaColor = "#5470c6")),
          emphasis = list(itemStyle = list(areaColor = "#5470c6"))
) %>%
    e_visual_map(value) %>%
    e_map_select(name = region_selected) %>% 
    e_tooltip() %>% 
    e_show_loading()
}
  # agri %>% filter(year == "2019") %>% 
  # draw_viet_map(cat = "prod",prod = "cereal")