library(rgdal)
library(magrittr)
library(leaflet)

shp0 <- readOGR("data/Lan_SCB", layer = "Lansgranser_SCB_07")

shp1 <- spTransform(shp0, CRS("+proj=longlat +datum=WGS84"))


leaflet(shp1) %>%
  addPolygons(
    stroke = FALSE, fillOpacity = 0.5, smoothFactor = 0.5,
    color = "red"
  ) %>%
  addTiles()


