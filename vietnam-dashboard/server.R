
library(shiny)
source(here("R-app/echart-maps.R"))
source(here("R-app/utils.R"))

agri = readRDS(here("data/agri.rds"))

# Define server logic required to draw a histogram
server = function(input,output ,session){
  output$viet_map = renderEcharts4r({
    agri %>% 
      filter(str_detect(category, input$category),
             year == "2019") %>% 
      filter(!region %in% .env$region) %>% 
      draw_viet_map()
  })  
  observeEvent(input$viet_map_clicked_data, print(input$viet_map_clicked_data))
}