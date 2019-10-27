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

choice <- colnames(unemployment)[-1:-6]
year = unemployment[-1:-6]

#choice <- substr(choice, 1,5)

# unemployment$label <- paste("<p>", unemployment$Region_Name, "</p>",
#                             "<p>", unemployment$population," ", unemployment$density, "</p>",
#                             "<p>", unemployment$lat," ", unemployment$lng, "</p>")