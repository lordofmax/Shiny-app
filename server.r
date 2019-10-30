library(shiny)
function(input, output){
 # want to show the unemployment rate in label how?
#   flights_delay <- reactive({
#     flights %>%
#       filter(origin == input$origin & dest == input$dest) %>%
#       group_by(carrier) %>%
#       summarise(n = n(),
#                 departure = mean(dep_delay),
#                 arrival = mean(arr_delay))
#   })
#   ...
# }
  # selected_year <- reactive({
  #   unemployment %>%
  #     select( == input$year)
  # })
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$OpenMapSurfer) %>%
      setView(lng = -98.58, lat = 39.82, zoom = 10) %>%  
      addTiles() %>% 
      addCircles(lng = unemployment$lng,
                 lat = unemployment$lat,
                 color = 'blue',
                 weight = 4,
                 radius = sqrt(unemployment$population) * 30,
                 popup = unemployment$Region_Name,
                 fillColor = "red",
                 label = unemployment$Region_Name)
  })
  #Data output on Data tab
  
  output$table <- DT::renderDataTable({
  	tmp <- datatable(unemployment, rownames = FALSE) 
  	tmp %>%
  		formatStyle(columns=colnames(tmp), background="skyblue", fontWeight='bold')
  	})
     
  output$plot1 <- renderPlot({
     sub_df <- data.frame(
        years = 2000:2018, 
        unemployment_1 = as.numeric(unemployment %>% 
                                       filter(., Region_Name == input$county1) %>% 
                                       select(., starts_with('X20'))),
        unemployment_2 = as.numeric(unemployment %>% 
                                       filter(., Region_Name == input$county2) %>% 
                                       select(., starts_with('X20'))))
     
     sub_df %>% ggplot(., aes(x = years, group = 1)) +
     	geom_line(aes(y = unemployment_1 ,colour='blue', size=3)) +
     	geom_line(aes(y = unemployment_2 ,colour='red', size=3)) +
     	xlab('Year') + ylab("Unemployment Rate By Percent") +
     	ggtitle("Interactive map of unemployment rate by counties")+
  	  theme(axis.text.x = element_text(angle = 45, hjust = 1),
            panel.background = element_rect(fill = 'grey75'),
            plot.title = element_text(size=10, face="bold",
                                    margin = margin(10, 0, 10, 0)))
  })
}

 


  