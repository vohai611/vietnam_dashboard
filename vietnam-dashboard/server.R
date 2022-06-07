
library(shiny)
source(here("R-app/utils.R"))
source(here("R-app/side-plot.R"))
source(here("R-app/echart-maps.R"))
source(here("R-app/side-area-plot.R"))

agri = readRDS(here("data/agri.rds"))
prod_rank = readRDS(here("data/prod_rank.rds"))
area_rank = readRDS(here("data/area_rank.rds"))
province_select = readRDS(here("data/province_select.rds"))

# Define server logic required to draw a histogram
server = function(input,output ,session){
  

# box  --------------------------------------------------------------------------------------------
 ## product box----
  ### on click -----
  observeEvent(input$tb_rank_prod,
               showModal(modalDialog(title = "Crop production ranks",
                                     renderDataTable({
                                       prod_rank %>% 
                                         filter(str_detect(category, input$product))
                                       }),
                                     size = "l",
                                     easyClose = TRUE)))
  
  output$prod_box = renderInfoBox({
    req(map_clicked())
    prod_rank = prod_rank %>% 
      filter(region == map_clicked()) %>% 
      filter(str_detect(category, input$product))
    
    country_rank =prod_rank$country_rank[[1]]
    region_rank =prod_rank$region_rank[[1]]
    
    color = case_when(country_rank <= 10 ~ "green",
                      country_rank <= 20 ~ "yellow",
                      TRUE ~ "red")
    
    infoBox(title = "Crop production",
            color = color,
            icon = icon("pagelines"),
            HTML("Country rank: ", prod_rank$country_rank[[1]],"<br/>",
                 "Region rank: ", prod_rank$region_rank[[1]], "<br/>",
                 '<i style="color:#9c9a95;font-size:14px;">', prod_rank$area[[1]], "<i/>"))
    
    
  })
  
  ## area box -----
  ### on click ----
  observeEvent(input$tb_rank_area, showModal(modalDialog(title = "Crop area ranks",
                                                         renderDataTable({area_rank %>% 
                                                             filter(str_detect(category, input$product))
                                                         }),
                                                         size = "l",
                                                         easyClose = TRUE)))
  
  output$area_box = renderInfoBox({
    req(map_clicked())
    area_rank = area_rank %>% 
      filter(region == map_clicked()) %>% 
      filter(str_detect(category, input$product))
    
    country_rank = area_rank$country_rank[[1]]
    region_rank = area_rank$region_rank[[1]] 
    
    color = case_when(country_rank <= 10 ~ "green",
                      country_rank <= 20 ~ "yellow",
                      TRUE ~ "red")
    
    infoBox(title = "Crop area",
            icon= icon("layer-group"),
            color = color,
            HTML("Country rank: ", country_rank,"<br/>",
                 "Region rank: ", region_rank, "<br/>",
                 '<i style="color:#9c9a95;font-size:14px;">', area_rank$area[[1]], "<i/>"))
    
    
  })
  
  # map ---------------------------------------------------------------------------------------------------
  
  output$viet_map = renderEcharts4r({
    agri %>% 
      filter( year == "2019") %>% 
      draw_viet_map(cat = category(), prod = input$product, map_clicked())
  })  
  
  
  
  # side chart --------------------------------------------------------------------------------------------
  
  output$province_crop = renderEcharts4r({
    req(map_clicked(), category())
    
    title = case_when(category() == "prod" ~ paste0("Crop Production of ", map_clicked()),
                      category() == "area" ~ paste0("Crop Area of ", map_clicked()))
    side_plot(agri, category(), region = map_clicked(),
              year = plot2_year(),
              title =title)
  })
  
  output$province_crop_time = renderEcharts4r({
    req(map_clicked(), category())
    
    title = case_when(category() == "prod" ~ paste0("Crop Production of ", map_clicked()),
                      category() == "area" ~ paste0("Crop Area of ", map_clicked()))
    
    product_names = c("cereal" ="Cereal",
                      "maize" ="Maize",
                      "paddy" ="Paddy",
                      "sw_potato" = "Sweet Potato")
    
    side_area_plot(agri, category(),
                   reg = map_clicked()) %>% 
      e_legend_select(product_names[[input$product]])
  })
  
  
  # table -------------------------------------------------------------------------------------------------
  
  
  # others ------------------------------------------------------------------------------------------------
  
  category = reactive({
    if(input$category == TRUE) "prod" else "area" 
  })
  
  map_clicked = reactiveVal("Ha Noi")
  observeEvent(input$province_select, map_clicked(input$province_select))
  observeEvent(input$viet_map_clicked_data$name, {
    province = input$viet_map_clicked_data$name
    map_clicked(province)
    updatePickerInput(session,"province_select",selected = province,
                      choices = province_select,
                      options = list(
                        `live-search` = TRUE))
    })
  
  onevent("mouseenter", "box1", showNotification("Click for more infor!",
                                                 type = "warning"))
  
  onevent("mouseenter", "box2", showNotification("Click for more infor!",
                                                 type = "warning"))
  
  plot2_year = reactive({
    input$province_crop_time_clicked_data$value[[1]] %||% "2019"
  })
  
  
}