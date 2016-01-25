shinyServer(function(input, output, session){
  
  colorpal <- reactive({
      input$clr
  })
  
    
  output$map <- renderLeaflet({
    
    leaflet(shp1) %>% addTiles() %>% 
      addProviderTiles("Thunderforest.Landscape") %>%
      #addGeoJSON(topoData, weight = 1, color = "#444444", fill = FALSE) %>%
      addPolygons(popup = shp1$LNNAMN) %>%
      #fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
      fitBounds(~17.13129, ~55.34004, ~30.14984, ~69.04774)
    
  })
  
  # Show a popup at the given location
#   showZipcodePopup <- function(lat, lng) {
#     leafletProxy("map") %>% addPopups(lat, lng, link)
#   }
#   
#   # When map is clicked, show a popup with city info
#   observe({
#     leafletProxy("map") %>% clearPopups()
#     event <- input$map_shape_click
#     click <- input$mapid_shape_click
#     if (is.null(event))
#       return()
#     
#     isolate({
#       #browser()
#       showZipcodePopup(event$lng, event$lat)
#     })
#   })
  

#   observe({
#     
#     pal <- colorpal()
#     
#     leafletProxy("map", data = shp1) %>%
#       clearShapes() %>%
#       #addCircles()
#       addPolygons(
#         stroke = FALSE, fillOpacity = 0.7, smoothFactor = 0.5,
#         color = ~colorNumeric(pal, as.numeric(shp1$LNKOD))(as.numeric(LNKOD))
#       )
# 
#   })
# 
#   observe({
#     proxy <- leafletProxy("map", data = shp1)
#     
#     # Remove any existing legend, and only if the legend is
#     # enabled, create a new one.
#     proxy %>% clearControls()
# #     if (input$clr) {
# #       pal <- colorpal()
# #       proxy %>% addLegend(position = "bottomright",
# #                           pal = pal, values = ~mag
# #       )
#     # }
#   })
  
  output$chart <- renderPlot({
    plot(1:10, (1:10)^2)
  })
    
}) 