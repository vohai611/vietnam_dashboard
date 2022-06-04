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

ui =  dashboardPage(
  title = "Vietnam Agriculture dashboard",
  dashboardHeader(),
  dashboardSidebar(width = "250px",
    selectInput("category", "Category", choices = c("Area" = "area", "Production" = "prod")),
    selectInput("product", "Product", choices = c("cereal", "maize", "paddy", "sw_potato"))
    
  ),
  dashboardBody(
    fluidRow(
      column(
        width = 6,
        fluidRow(

# box ---------------------------------------------------------------------------------------------------
          infoBoxOutput(width = 6,
                        outputId = "prod_box"),
          infoBoxOutput(width = 6, outputId = "yield_box")),

# map ---------------------------------------------------------------------------------------------------

        box(
          width = NULL, 
          title = "Viet map",
          height = NULL,
          fluidRow(echarts4rOutput("viet_map", height = "800px"))
        )
      ),

# side_chart --------------------------------------------------------------------------------------------

      column(width = 6,
             box(title = "chart", width = NULL,
               echarts4rOutput("province_crop")
             ),
             box(title = "table"))
      )))