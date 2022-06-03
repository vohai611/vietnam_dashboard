library(gsovn)
library(tidyverse)

region = c(
  "WHOLE COUNTRY",
  "Northern midlands and mountain areas",
  "Red River Delta",
  "Northern Central area and Central coastal area",
  "Central Highlands",
  "South East",
  "Mekong River Delta" 
)
region_regex = paste0("(", str_c(region, collapse  =  "|"), ")")
# Agriculture dashboard
# data source
by_province = gso_avail("en", "province")


clean_1  = . %>% 
  rename("region" = 1) %>% 
  mutate(across(-region, ~str_remove(.x, ",") %>%   as.numeric)) %>% 
  mutate(region_group = cumsum(str_detect(region, region_regex))) %>% 
  group_by(region_group) %>% 
  mutate(area = first(region)) %>% 
  ungroup() %>% 
  select(-region_group)