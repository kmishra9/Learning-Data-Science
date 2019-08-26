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
  geom_point(data = sales, mapping=aes(x=lon, y=lat, color = year_built))

################################################################################
# Excersise 3 - Getting Different Maps

corvallis_map_sat = get_map(location = corvallis, zoom = 13, maptype = "satellite", source = "google")

ggmap(corvallis_map_sat) +
  geom_point(data = sales, mapping = aes(lon, lat, color = year_built))

################################################################################
# Excersise 4 - Adding a base_layer -- concise + allows facets

ggmap(
  ggmap = corvallis_map_sat,
  base_layer = ggplot(mapping = aes(x=lon, y=lat), data = sales)
) +
  geom_point(mapping = aes(color = year_built)) +
  facet_wrap(class ~ .)

################################################################################
# Excersise 5 - Concise ggmaps with qmplot()

qmplot(
  x = lon,
  y = lat,
  data = sales,
  geom = "point",
  color = bedrooms
) +
  facet_wrap(~ month)

################################################################################
# Excersise 6 - Polygon layers in ggplot
ggplot(ward_sales, aes(lon, lat)) +
  geom_polygon(mapping=aes(group=group, fill=ward, alpha=avg_price))

################################################################################
# Excersise 7 - Preventing off-map cropping
ggplot(ward_sales, aes(lon, lat)) +
  geom_polygon(mapping=aes(group=group, fill=ward, alpha=avg_price))

qmplot(lon, lat, data = ward_sales, geom = "polygon", group = group, fill = avg_price)

################################################################################
# Excersise 8 - Polygons on a GGmap
ggmap(
  corvallis_map_bw,
  base_layer = ggplot(ward_sales, aes(lon, lat)),
  extent = "normal",
  maprange = FALSE
) +
  geom_polygon(aes(group = group, fill = num_sales))

################################################################################
# Excersise 9 - Heatmaps in ggplot and ggmap
ggplot(preds, aes(lon, lat)) +
  geom_tile(mapping=aes(fill=predicted_price))

ggmap(
  ggmap = corvallis_map_bw,
  base_layer = ggplot(data = preds, mapping = aes(x=lon, y=lat)),
  extent = "normal",
  maprange = FALSE
) +
  geom_tile(mapping = aes(fill=predicted_price), alpha=.8)

################################################################################
# Excersise 10 - Working with SpatialPolygonsDataFrame (shape files)

# Subsetting
usa = countries_spdf[169,]

# Understanding the structure of a spdf
summary(usa)
str(usa, max.level=2)
plot(usa)

# Accessing Slots
head(countries_spdf@data)
str(countries_spdf@data)

# Accessing columns
countries_spdf$name
countries_spdf[["subregion"]]
