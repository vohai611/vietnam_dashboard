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
library(echarts4r)
library(shinydashboard)
library(shinydashboardPlus)

ui =  dashboardPage(
  title = "Vietnam Agriculture dashboard",
  dashboardHeader(),
  dashboardSidebar(
    selectInput("category", "Category", choices = c("Area" = "area", "Production" = "prod"))
    
  ),
  dashboardBody(
    column(6, box(title = "Viet map",height = NULL,
                  fluidRow(echarts4rOutput("viet_map", height = "800px"))
    )),
    column(6,
           box(width = 6, 
               plotOutput("province_crop")))
    
  
  
))