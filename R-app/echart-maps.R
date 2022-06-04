library(echarts4r)

draw_viet_map =  function(data) {
  data %>%
    group_by(year) %>% 
    e_chart(region, timeline = TRUE) %>%
    e_map_register('vn', haitools::small_vnjson) %>%
    e_map(value, map = 'vn') %>%
    e_visual_map(value) %>%
    e_show_loading()
  }
