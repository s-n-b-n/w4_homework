library(maptools)
library(RColorBrewer)
library(classInt)
library(sp)
library(rgeos)
library(tmap)
library(tmaptools)
library(sf)
library(rgdal)
library(geojsonio)
library(tidyverse)
library(countrycode)
library(janitor)


#stringr package - can change the string on the value. i.e.- erase the spacing in front of the string
library(stringr)

#getwd() let me know where my working folder is. setwd() makes this folder as working folder.
getwd()

WM <- st_read('World_Countries__Generalized_.shp')
qtm(WM)

GII <- read_csv('Gender Inequality Index (GII).csv',
                locale = locale(encoding = 'latin1'),
                na = '..')

# GIItest <- GII %>%
#   clean_names()

GIIcols <- GII %>%
  clean_names() %>%
  select(country, x2019, x2010)%>%
  mutate(difference=x2019-x2010)%>%
  slice(1:189,)%>%
  mutate(iso_code=countrycode(country, origin = 'country.name', destination = 'iso2c'))

# t <- countrycode(GIIcols$country, origin='country.name', destination = 'iso2c')

Join_GII <- WM %>%
  clean_names() %>%
  left_join(.,
            GIIcols,
            by= c('aff_iso' = 'iso_code'))
# 
# library(usethis)
# use_github()
# 
# 
# #let's try to plot this on map
# Join_GII
# 
# 
# #Initial trial <- errorrrr....  // merging two files with the 'country' column from each
# OnMap <- WM %>%
#   merge(.,
#         GII,
#         by.x='COUNTRY',
#         by.y='Country')
# 
# 
# OnMap %>%
#   head(., n=3)
# 
# edit(OnMap)


# Visualization: week 5 homework - Devin Johnson Hogan
tm_shape(Join_GII)+
  tm_polygons('difference')
# this is a quick visualization showing the change in global gender equality between 2010 and 2019
# the color scale is diverging with a midpoint at 0
# note that negative values indicate an improvement in the gender equality metric






