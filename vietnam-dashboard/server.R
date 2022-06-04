
library(shiny)
source(here("R-app/echart-maps.R"))
source(here("R-app/utils.R"))
source(here("R-app/side-plot.R"))


agri = readRDS(here("data/agri.rds"))

# Define server logic required to draw a histogram
server = function(input,output ,session){
  

# box  --------------------------------------------------------------------------------------------

  

# map ---------------------------------------------------------------------------------------------------

  output$viet_map = renderEcharts4r({
    agri %>% 
      filter(str_detect(category, input$category),
             year == "2019") %>% 
      filter(!region %in% .env$region) %>% 
      draw_viet_map()
  })  
  
  

# side chart --------------------------------------------------------------------------------------------

  output$province_crop = renderEcharts4r({
    req(map_clicked(), input$category)
    
    isolate({ 
      side_plot(agri, input$category, region = map_clicked())
    })
  })
  

# table -------------------------------------------------------------------------------------------------


# others ------------------------------------------------------------------------------------------------

  map_clicked = reactive({req(length(input$viet_map_clicked_data$name) == 1)
    isolate(input$viet_map_clicked_data)
    })
  
  
}