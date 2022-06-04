
library(shiny)
source(here("R-app/utils.R"))
source(here("R-app/side-plot.R"))
source(here("R-app/echart-maps.R"))
source(here("R-app/side-area-plot.R"))

agri = readRDS(here("data/agri.rds"))
prod_rank = readRDS(here("data/prod_rank.rds"))
area_rank = readRDS(here("data/area_rank.rds"))

# Define server logic required to draw a histogram
server = function(input,output ,session){
  

# box  --------------------------------------------------------------------------------------------
  output$prod_box = renderInfoBox({
    req(map_clicked())
    prod_rank = prod_rank %>% 
      filter(region == map_clicked()) %>% 
      filter(str_detect(category, input$product))
    
   infoBox(title = "Yield production",
           icon = icon("pagelines"),
             HTML("Country rank: ", prod_rank$country_rank[[1]],"<br/>",
                    "Region rank: ", prod_rank$region_rank[[1]], "<br/>",
                  '<i style="color:#9c9a95;font-size:14px;">', prod_rank$area[[1]], "<i/>"))
      
    
  })
  

  output$area_box = renderInfoBox({
    req(map_clicked())
    area_box = area_rank %>% 
      filter(region == map_clicked()) %>% 
      filter(str_detect(category, input$product))
    
    infoBox(title = "Yield area",
            icon= icon("layer-group"),
            HTML("Country rank: ", area_box$country_rank[[1]],"<br/>",
                 "Region rank: ", area_box$region_rank[[1]], "<br/>",
                 '<i style="color:#9c9a95;font-size:14px;">', area_box$area[[1]], "<i/>"))
    
    
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
    
      title = case_when(input$category == "prod" ~ paste0("Yield Production of ", map_clicked()),
                        input$category == "area" ~ paste0("Yield Area of ", map_clicked()))
      side_plot(agri, input$category, region = map_clicked(),
                title =title)
  })
  
  output$province_crop_time = renderEcharts4r({
    req(map_clicked(), input$category)
    
    title = case_when(input$category == "prod" ~ paste0("Yield Production of ", map_clicked()),
                      input$category == "area" ~ paste0("Yield Area of ", map_clicked()))
    side_area_plot(agri, input$category, reg = map_clicked())
  })
  

# table -------------------------------------------------------------------------------------------------


# others ------------------------------------------------------------------------------------------------

  
  map_clicked = reactive({req(length(input$viet_map_clicked_data$name) == 1)
    isolate(input$viet_map_clicked_data$name)
    })
  
  
}