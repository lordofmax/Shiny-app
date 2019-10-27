function(input, output, session) {
 # want to show the unemployment rate in label how?
    output$map <- renderleaflet({
    leaflet(unemployment) %>%
      addProviderTiles(providers$OpenMapSurfer) %>%
      setView(lng = -98.58, lat = 39.82, zoom = 5) %>%  
      addTiles() %>% 
      addCircles(lng = unemployment$lng,
                 lat = unemployment$lat,
                 color = 'gray',
                 weight = 4,
                 radius = sqrt(unemployment$population) * 30,
                 popup = unemployment$Region_Name,
                 fillColor = "red",
                 label = unemployment$Region_Name)
  })
  #Data output on Data tab
  output$table <- DT:: renderDataTable({
  	datatable(unemployment, rownames = FALSE) %>%
  		formatStyle( background="skyblue", fontWeight='bold')
  	})

  output$plot1 <- renderPlot({
  	ggplot(unemployment, aes(x = year, group = 1)) +
  	geom_line(aes(y=input$county1 ,colour='blue', size=3)) +
  	geom_line(aes(y=input$county2 ,colour='red', size=3)) +
  	xlab('Year') + ylab("Unemployment Rate By Percent") +
  	ggtitle("Interactive map of unemployment rate by counties") +
  	theme(axis.text.x = element_text(angle = 45, hjust = 1),
          panel.background = element_rect(fill = 'grey75'),
          plot.title = element_text(size=10, face="bold", 
                                    margin = margin(10, 0, 10, 0)))
  })
}

 


  