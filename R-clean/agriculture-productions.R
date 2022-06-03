source("R-clean/utils.R")

# cereal ------------------------------------------------------------------------------------

## planted area

cereal_area = gso_read(by_province$link[57])$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region, area), names_to = "year") %>% 
  mutate(category = "cereal_area")

## production
cereal_prod =  gso_read(by_province$link[58])$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region,area), names_to = "year") %>% 
  mutate(category = "cereal_prod")


## per capita 
#gso_read(by_province$link[59])


# maize  ------------------------------------------------------------------------------------------------
maize = gso_avail("en", "maize")
## area
maize_area = gso_read(maize$link[1])$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region,area), names_to = "year") %>% 
  mutate(category = "maize_area")


## production 
maize_prod = gso_read(maize$link[3])$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region,area), names_to = "year") %>% 
  mutate(category = "maize_prod")


# paddy -------------------------------------------------------------------------------------------------

## area
paddy_area = gso_read(by_province$link[60])$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region,area), names_to = "year") %>% 
  mutate(category = "paddy_area")


paddy_prod = gso_read(by_province$link[62])$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region,area), names_to = "year") %>% 
  mutate(category = "paddy_prod")

# cassava -----------------------------------------------------------------------------------------------
cassava_area = gso_read(by_province$link[77])$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region,area), names_to = "year") %>% 
  mutate(category = "cassava_area")

cassava_prod = gso_read(by_province$link[78])$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region,area), names_to = "year") %>% 
  mutate(category  = "cassava_prod")



## sweet potato production ---------------------------------------
sw_potato_area = gso_read(by_province$link[75])$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region,area), names_to = "year") %>% 
  mutate(category = "sw_potato_area")

sw_potato_prod = gso_read(by_province$link[76])$data %>% 
  clean_1() %>% 
  pivot_longer(-c(region,area), names_to = "year") %>% 
  mutate(category = "sw_potato_prod")



agri = list(cereal_area, maize_area, paddy_area, cassava_area, sw_potato_area,
                 cereal_prod, maize_prod, paddy_prod, cassava_prod, sw_potato_prod) %>% 
  data.table::rbindlist() %>% 
  as_tibble()
  
agri = agri %>% 
   mutate(region = str_to_title(str_squish(region))) %>% 
   mutate(region = case_when(region  == "Thua Thien-Hue"~ "Thua Thien Hue",
                             TRUE ~ region)) 
library(here)
saveRDS(agri, here("data/agri.rds"))
 
 

 












