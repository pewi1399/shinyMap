library(rgdal)
library(magrittr)
library(leaflet)
library(ggplot2)
library(maptools)
library(rCharts)

shp0 <- readOGR("data/Lan_SCB", layer = "Lansgranser_SCB_07")

shp1 <- spTransform(shp0, CRS("+proj=longlat +datum=WGS84"))

# cant seem to find id- field
shp1$id <- shp1$LNKOD

# dat0 <- fortify(shp1, region = "LNKOD")
#names(dat0)

# leaflet(shp1) %>%
#   addPolygons(
#     stroke = FALSE, fillOpacity = 0.5, smoothFactor = 0.5,
#     color = "red"
#   ) %>%
#   addTiles()

dat0 <- data.frame(lan = c("01", "03", "04", "05", "06", "07", 
                           "08", "09", "10", "12", "13", "14", "17", "18", "19", "20", "21", 
                           "22", "23", "24", "25"))
dat0$xval <- rnorm(nrow(dat0))
dat0$yval <- rnorm(nrow(dat0),4)

p1 <- nPlot(yval~xval, group = "lan", data = dat0, type = "scatterChart")

p1$yAxis(
  tickFormat=
    "#!function(d) {
  return d.toFixed(2);
  }!#"
)

p1$xAxis(
  tickFormat=
    "#!function(d) {
  return d.toFixed(2);
  }!#"
)

# links 
link <- "https://sv.wikipedia.org/wiki/V%C3%A4sternorrlands_l%C3%A4n"
link <- paste0('<a href=', link, ' target="_blank">Lan</a>')

