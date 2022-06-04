
library(shiny)
source(here("R-app/utils.R"))
source(here("R-app/side-plot.R"))
source(here("R-app/echart-maps.R"))

agri = readRDS(here("data/agri.rds"))
prod_rank = readRDS(here("data/prod_rank.rds"))

# Define server logic required to draw a histogram
server = function(input,output ,session){
  

# box  --------------------------------------------------------------------------------------------
  output$prod_box = renderInfoBox({
    prod_rank = prod_rank %>% 
      filter(region == map_clicked()) %>% 
      filter(str_detect(category, input$product))
    
   infoBox(title = "Production",
             HTML("Country rank: ", prod_rank$country_rank[[1]],"<br/>",
                    "Region rank: ", prod_rank$region_rank[[1]], "<br/>",
                  '<i style="color:#9c9a95;font-size:14px;">', prod_rank$area[[1]], "<i/>"))
      
    
  })
  

# map ---------------------------------------------------------------------------------------------------

  output$viet_map = renderEcharts4r({
    agri %>% 
      filter( year == "2019") %>% 
      draw_viet_map(cat = input$category, prod = input$product)
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
    isolate(input$viet_map_clicked_data$name)
    })
  
  
}