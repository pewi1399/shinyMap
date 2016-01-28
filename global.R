#library(rgdal)
library(magrittr)
library(leaflet)
library(htmlwidgets)
#library(jsonlite)
library(shiny)

# setwd("H:/Dokument/Git_repos/shiny/shinyMap")
# 
# # -------------------- get shapefile and reformat to geoJSON -------------------
# shp0 <- readOGR("data/Lan_SCB", layer = "Lansgranser_SCB_07")
# 
# shp1 <- spTransform(shp0, CRS("+proj=longlat +datum=WGS84"))
# 
# dat0 <- data.frame(shp1)
# dat1 <- dat0[,c("LNKOD", "LNNAMN", "BEF05", "LANDAREAKM")]
# 
# 
# #cant seem to find id- field
# #shp1$LNNAMN <- NULL
# #shp1$BEF05 <- NULL
# #shp1$LANDAREAKM <- NULL
# shp1$AREA98KM2 <- NULL
# shp1$KOD97 <- NULL
# shp1$KOD74_96 <- NULL
# shp1$URNAMN <- NULL
# shp1$BEF96 <- NULL
# #shp1$LNNAMN <- enc2utf8(as.character(shp1$LNNAMN))
# shp1$LNNAMN <- as.character(shp1$LNNAMN)
# shp1$LNNAMN <- enc2utf8(shp1$LNNAMN)
# 
# shp1$LNNAMN <- gsub("Ã¶","ö",shp1$LNNAMN)
# shp1$LNNAMN <- gsub("Ã¥","å",shp1$LNNAMN)
# shp1$LNNAMN <- gsub("Ã¤","ä",shp1$LNNAMN)
# 
# shp1$LNNAMN <- gsub("Ã¶","ö",shp1$LNNAMN)
# shp1$LNNAMN <- gsub("Ã–rebro","Örebro",shp1$LNNAMN)
# shp1$LNNAMN[14] <- enc2utf8("Örebro")
# shp1$LNNAMN[4] <- enc2utf8("Östergötlands")
# 
# writeOGR(shp1, "lanMap.geojson",'lanMap', driver='GeoJSON')

geojson <- readLines("lanMap.geojson", warn = FALSE, encoding = "UTF-8") %>%
  paste(collapse = "\n") %>%
  jsonlite::fromJSON(simplifyVector = FALSE)

geojson$style = list(
  weight = 1,
  color = "red",
  fillColor = "grey",
  opacity = 1,
  fillOpacity = 0.8
)


tatorter <- readRDS("data/ortData.rds")


pal <- colorQuantile("YlOrRd", tatorter$sizeOnMap)
# colorvar <- sapply(geojson$features, function(feat) {
#   feat$properties["BEF05"]
# })

colorvar <- sapply(geojson$features, function(feat) {
  feat$properties["BEF05"]
})

# color by chosen variable
polyPal <- colorQuantile("Oranges", unlist(colorvar))

# repaint
geojson$features <- lapply(geojson$features, function(feat) {
  feat$properties$style <- list(
    fillColor = polyPal(as.numeric(feat$properties["BEF05"])),
    color = "grey"
  )
  feat
})

#structure
# ------------------------------------------------------------------------------

# ------------------------------- plot panel -----------------------------------
# dat0 <- data.frame(lan = c("01", "03", "04", "05", "06", "07", 
#                            "08", "09", "10", "12", "13", "14", "17", "18", "19", "20", "21", 
#                            "22", "23", "24", "25"))
# dat0$xval <- rnorm(nrow(dat0))
# dat0$yval <- rnorm(nrow(dat0),4)
# 
# p1 <- nPlot(yval~xval, group = "lan", data = dat0, type = "scatterChart")
# 
# p1$yAxis(
#   tickFormat=
#     "#!function(d) {
#   return d.toFixed(2);
#   }!#"
# )
# 
# p1$xAxis(
#   tickFormat=
#     "#!function(d) {
#   return d.toFixed(2);
#   }!#"
# )

# links 
link <- "https://sv.wikipedia.org/wiki/V%C3%A4sternorrlands_l%C3%A4n"
link <- paste0('<a href=', link, ' target="_blank">Lan</a>')
# ------------------------------------------------------------------------------
