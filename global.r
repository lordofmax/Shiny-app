library(shinydashboard)
library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(DT)
library(leaflet)
library(googleVis)
library(corrplot)
library(ggcorrplot)
library(glue)
library(plotly)
library(htmltools)
library(htmlwidgets)

unemployment = read.csv("US_unemployment_rate.csv")


# 
# years <- unemployment %>% select(-Region_Name,-state_name,-lat,-lng,-population,-density)
# to_str <- function(yr) {
#   return (substr(yr, 2, 5))
# }
# 
# names(unemployment)[7:length(names(unemployment))] <- lapply(names(years), to_str)
choice <- colnames(unemployment)[-1:-6]
