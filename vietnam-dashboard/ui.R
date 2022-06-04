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
library(plotly)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)

ui =  dashboardPage(
  title = "Vietnam Agriculture dashboard",
  dashboardHeader(),
  dashboardSidebar(width = "250px",
                   selectInput("category", "Category",
                               choices = c("Area" = "area", "Production" = "prod"))

  ),
  dashboardBody(
    #tags$style("@import url(https://use.fontawesome.com/releases/v5.7.2/css/all.css);"),
    fluidRow(
      column(
        width = 6,
        fluidRow(
          
        # box ---------------------------------------------------------------------------------------------------
          infoBoxOutput(width = 6,
                        outputId = "prod_box"),
          infoBoxOutput(width = 6, 
                        outputId = "area_box")), 
        
        # choices -----------------------------------------------------------------------------------------------
        
        radioGroupButtons(
          inputId = "product",justified = TRUE,
          label = NULL, 
          choices = c(Cereal = "cereal",
                      Maize =  "maize", 
                      Paddy =  "paddy", 
                      `Sweet Potato` = "sw_potato"),
          status = "primary"
        ),
        
        # map ---------------------------------------------------------------------------------------------------
        box(
          width = NULL, 
          title = NULL,
          height = NULL,
          fluidRow(echarts4rOutput("viet_map", height = "800px"))
        )
      ),
      
      # side_chart --------------------------------------------------------------------------------------------
      
      column(width = 6,
             box(
               title = NULL,
               width = NULL,
               echarts4rOutput("province_crop")
             ),
             box(title = NULL,
                 width = NULL,
                 echarts4rOutput("province_crop_time")))
    )))
