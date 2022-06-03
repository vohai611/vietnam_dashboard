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

#  number of farms by provinces 55
n_farms = gso_read(by_province$link[55])


clean_1  = . %>% 
  rename("region" = 1) %>% 
  mutate(across(-region, ~str_remove(.x, ",") %>%   as.numeric)) %>% 
  mutate(region_group = cumsum(str_detect(region, region_regex))) %>% 
  group_by(region_group) %>% 
  mutate(area = first(region)) %>% 
  ungroup()



# n_farms -----------------------------------------------------------------------------------------------

n_farms = n_farms$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region, area), names_to = "year")

# n farms by activities ---------------------------------------------------------------------------------

n_farm_by_activities =  gso_read(by_province$link[56])$data

new_name = paste0(n_farm_by_activities[1, ],"_", names(n_farm_by_activities))
new_name[1] = "region"

n_farm_by_activities = n_farm_by_activities[-1,]
names(n_farm_by_activities) = new_name

n_farm_by_activities %>% 
  clean_1() %>% 
  pivot_longer(-c(region, area), names_to= c("category", "year"), names_sep = "_")


n_farms %>% 
  filter(year == '2011')


