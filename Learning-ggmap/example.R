################################################################################
# Excersise 1

library(ggmap)
corvallis <- c(lon = -123.2620, lat = 44.5646)

# Get map at zoom level 5: map_5
map_5 = get_map(location = corvallis, zoom = 5, scale = 1)

# Plot map at zoom level 5
ggmap(ggmap=map_5)

# Get map at zoom level 13: corvallis_map
corvallis_map = get_map(location = corvallis, zoom = 13, scale = 1)

# Plot map at zoom level 13
ggmap(ggmap=corvallis_map)

################################################################################
# Excersise 2 - Overlaying Points + Adding Aesthetics

ggmap(ggmap=corvallis_map) +
  geom_point(data = sales, mapping=aes(lon, lat, color = year_built))

################################################################################
# Excersise 3 - Getting Different Maps

corvallis_map_sat = get_map(location = corvallis, zoom = 13, maptype = "satellite", source = "google")

ggmap(corvallis_map_sat) +
  geom_point(data = sales, mapping = aes(lon, lat, color = year_built) )
