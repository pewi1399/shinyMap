library(XLConnect)
library(ggmap)
library(dplyr)
library(testthat)

# grab data from scb with tatorts-size
tatorter <- readWorksheetFromFile("data/MI0810_To_So_Kommun2010.xls", sheet = 1)

# get totals remove auxillary data
tatorter <- tatorter[tatorter[,"Col4"] == "Totalt" & !is.na(tatorter[,"Col4"] == "Totalt") ,]
tatorter <- tatorter[,c(2,5)] #only interested in name and size
tatorter <- tatorter[-1,] # first row is country total

# rename
names(tatorter) <- c("ort", "size")

# geocode for coordinates
coords <- geocode(tatorter$ort)
tatorter <- cbind(tatorter, coords)

# seems like geocoding worked in most instances
plot(tatorter$lon, tatorter$lat)
text(tatorter$lon, tatorter$lat, labels = tatorter$ort)

# sweden ends at approximately latitude 55 degrees all values below are wrong 
problem <- tatorter[tatorter$lat<55,]

# define country and redo
problem$extraInfo <- paste(problem$ort, "Sweden")
problem_coords <- geocode(problem$extraInfo)
points(problem_coords, col = "red") #success

# insert new coordinates
problem <- problem %>%
  select(ort, size) %>% 
  cbind(problem_coords)

# put fixed problems back in file
tatorter <- tatorter %>%
  filter(lat>55) %>% 
  rbind(problem)

# redraw for informal test
#plot(tatorter$lon, tatorter$lat)

# stupid nbsp (or similar)
tatorter$size <- as.numeric(gsub("\\s", "", tatorter$size))

# reorder so that smaller populations are plotted on top of larger
tatorter <- arrange(tatorter, -size)

# we need to do some rescaling for this visualization to be meaningful
tatorter$sizeOnMap <- tatorter$size/max(tatorter$size) * 50000


saveRDS(tatorter, "data/ortData.rds")
