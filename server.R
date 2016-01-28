shinyServer(function(input, output, session){
  
  
  # always print basemap
  output$map <- renderLeaflet({
    
    leaflet() %>% addTiles() %>% 
      addProviderTiles("Hydda.Base") %>%
      #addGeoJSON(geojson, weight = 1, fill = TRUE) %>%
      #addPolygons(popup = shp1$LNNAMN) %>%
      #fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
      fitBounds(17.13129, 55.34004, 30.14984, 69.04774)
    
  })
  
 lan <- reactive({
  if(is.null(input$map_geojson_click)){
    ""
  }else{
    geojson$features[[input$map_geojson_click$featureId+1]]$properties$LNNAMN
  }
  })

 observe({
 # Separate point and shape layers
 if(input$type){ # points
  leafletProxy("map") %>% 
    clearGeoJSON() %>%
    clearControls() %>% 
    addCircles(tatorter$lon, tatorter$lat, radius = tatorter$sizeOnMap,
                popup = tatorter$ort, color = pal(tatorter$sizeOnMap)) %>% 
     addLegend("bottomleft", pal = pal, 
               values = tatorter$sizeOnMap,
               title = "Kvartil")
   
 }else{
   
   leafletProxy("map") %>% 
     clearShapes() %>% 
     addGeoJSON(geojson, weight = 1, fill = TRUE) %>% 
         addLegend("bottomleft", pal = polyPal, 
              values = unlist(colorvar),
              title = "Kvartil")
   
 # Show a popup at the given location
  showZipcodePopup <- function(lat, lng, id) {
    
    wikilink <- "https://sv.wikipedia.org/wiki/"
    link <- gsub(" ", "_", paste0(wikilink,lan(),"_län"))
    link <- paste0('<a href=', link, ' target="_blank">', gsub("s$", "", lan()), '</a>') 
    
    leafletProxy("map") %>% addPopups(lat, lng, link)
  } 
  
  # When map is clicked, show a popup 
  observe({
    leafletProxy("map") %>% clearPopups()
    event <- input$map_geojson_click
    if (is.null(event))
      return()
    
    isolate({
      #browser()
      showZipcodePopup(event$lng, event$lat, event$featureId)
    })
  })
  
  observe({ 
    
    #browser()
      
    leafletProxy("map") %>%
      clearGeoJSON() %>%
      clearControls() %>%
      #addCircles()
      addGeoJSON(geojson) %>%
      addLegend("bottomleft", pal = polyPal, 
                values = unlist(colorvar),
                title = "Kvartil")

 
  }) 
 }
 })

  
  output$chart <- renderPlot({
    plot(1:30, (1:30)^2, col = "dodgerblue")
    text(gsub("s$", "", lan()),x = 15, y = 500, cex = 1.6)
    })
    
}) 