library(shiny)
library(leaflet)
library(RColorBrewer)

shinyUI(
  bootstrapPage(
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
    leafletOutput("map", width = "100%", height = "100%"),
    absolutePanel(top = 10, right = 10,
                  selectInput("clr", "Colorsheme",
                              row.names(subset(brewer.pal.info, category %in% c("seq", "div")))
                  )
    )
    
    )
)