shinyServer(function(input, output, session){
  
  colorpal <- reactive({
      input$clr
  })
    
  output$map <- renderLeaflet({
    
    leaflet(shp1) %>% addTiles() %>%
      #fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
      fitBounds(~11.13129, ~55.34004, ~24.14984, ~69.04774)
    
  })

  observe({
    
    pal <- colorpal()
    
    leafletProxy("map", data = shp1) %>%
      clearShapes() %>%
      #addCircles()
      addPolygons(
        stroke = FALSE, fillOpacity = 0.5, smoothFactor = 0.5,
        color = ~colorQuantile(pal, shp1$LANDAREAKM)(LANDAREAKM)
      )

  })

  observe({
    proxy <- leafletProxy("map", data = shp1)
    
    # Remove any existing legend, and only if the legend is
    # enabled, create a new one.
    proxy %>% clearControls()
#     if (input$clr) {
#       pal <- colorpal()
#       proxy %>% addLegend(position = "bottomright",
#                           pal = pal, values = ~mag
#       )
    # }
  })
    
}) 