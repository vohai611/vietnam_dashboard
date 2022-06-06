
library(tidyverse)
agri = read_rds("data/agri.rds")
source("R-clean/utils.R")

# production rank ---------------------------------------------------------------------------------------

prod_rank = agri %>% 
  filter(! region %in% str_to_title(.env$region)) %>% 
  filter(year == 2019) %>% 
  filter(str_detect(category, "prod")) %>% 
  group_by(category) %>% 
  mutate(country_rank = min_rank(desc(value))) %>% 
  ungroup() %>% 
  group_by(area, category) %>% 
  mutate(region_rank = min_rank(desc(value)))
  
write_rds(prod_rank,"data/prod_rank.rds")

# crop area rank --------------------------------------------------------------------------------------

area_rank = agri %>% 
  filter(! region %in% str_to_title(.env$region)) %>% 
  filter(year == 2019) %>% 
  filter(str_detect(category, "area")) %>% 
  group_by(category) %>% 
  mutate(country_rank = min_rank(desc(value))) %>% 
  ungroup() %>% 
  group_by(area, category) %>% 
  mutate(region_rank = min_rank(desc(value)))

write_rds(area_rank, "data/area_rank.rds")
  

