agri = readRDS("data/agri.rds")
source("R-clean/utils.R")
region
province_select = unique(agri$region)

province_select = province_select[!province_select %in% str_to_title(region)]
write_rds(province_select,"data/province_select.rds")
