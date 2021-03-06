#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(here)
library(dplyr)
library(stringr)
library(ggplot2)
library(forcats)
library(echarts4r)
library(shinydashboard)
#library(shinydashboardPlus)
library(shinyWidgets)
library(shinyjs)
library(shinyBS)

province_select = readRDS(here("data/province_select.rds"))

ui =  dashboardPage(
  title = "Vietnam Agriculture dashboard",
  dashboardHeader(disable = TRUE),
  dashboardSidebar(width = "250px",
                   switchInput(
                     label = "Category",
                     inputId = "category",
                     onLabel = "Production",
                     value = TRUE,
                     offLabel = "Area",
                   ),
                   pickerInput(
                     inputId = "province_select",
                     label = "Province/City",width = "200px",
                     choices = province_select,
                     options = list(
                       `live-search` = TRUE)
                   )
                   # selectInput("category", "Category",
                   #             choices = c("Area" = "area", "Production" = "prod"))
                   
  ),
  dashboardBody(
    useShinyjs(),
    tags$head(tags$link(rel = 'stylesheet', type = "text/css",href = "style.css")),
    #tags$style("@import url(https://use.fontawesome.com/releases/v5.7.2/css/all.css);"),
    fluidRow(
      column(
        
        width = 6,
        
        # choices -----------------------------------------------------------------------------------------------
        
        radioGroupButtons(
          inputId = "product",justified = TRUE,
          label = NULL, 
          choices = c(Cereal = "cereal",
                      Paddy =  "paddy", 
                      Maize =  "maize", 
                      `Sweet Potato` = "sw_potato"),
          status = "primary"
        ),
        
        # map ---------------------------------------------------------------------------------------------------
        box(
          solidHeader = TRUE,
          width = NULL, 
          title = NULL,
          height = NULL,
          fluidRow(echarts4rOutput("viet_map", height = "800px"))
        )
      ),
      
      # side_chart --------------------------------------------------------------------------------------------
      
      column(width = 6,
             fluidRow(
               box(headerBorder = TRUE,
                   solidHeader = TRUE,
                   infoBoxOutput(width = 12,
                                 outputId = "prod_box"),
                   actionBttn(size = "xs",block = TRUE,
                              inputId = "tb_rank_prod",
                              label = "Show all",
                              style = "fill", 
                              icon = icon("bars"),
                              color = "warning"
                   ) 
               ),
               box(solidHeader = TRUE,
                   
                   infoBoxOutput(width = 12, 
                                 outputId = "area_box"),
                   actionBttn(size = "xs",block = TRUE,
                              inputId = "tb_rank_area",
                              label = "Show all",
                              style = "fill", 
                              icon = icon("bars"),
                              color = "warning"
                   ) 
               )),
             
             # box ---------------------------------------------------------------------------------------------------
             box(
               solidHeader = TRUE,
               title = NULL,
               width = NULL,
               echarts4rOutput("province_crop",height = "300px")
             ),
             box(title = NULL,
                 solidHeader = TRUE,
                 width = NULL,
                 echarts4rOutput("province_crop_time", height = "320px")))
    )))
