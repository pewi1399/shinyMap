library(shiny)
library(leaflet)
library(RColorBrewer)

shinyUI(
  bootstrapPage(
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
    tags$head(includeCSS("styles.css")),
    leafletOutput("map", width = "100%", height = "100%"),
    absolutePanel(top = 10, right = 10,
                  selectInput("type", "Diagramtyp",
                              selected = TRUE,
                              c(Punkt = TRUE, Polygon = FALSE)
                  )
    ),
    # Shiny versions prior to 0.11 should use class="modal" instead.
    absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                  draggable = TRUE, top = 550, left = "auto", right = 20, bottom = "auto",
                  width = 330, height = "auto",
                  
                  h2("Befolkning"),
                  h3(as.character(packageVersion("leaflet"))),
                  
                 # selectInput("color", "Color", c("gg", "yy")),
                  #showOutput("chart", "nvd3")
                  plotOutput("chart", height = 250)
    
    )
)
)