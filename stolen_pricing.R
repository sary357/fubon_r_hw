#install.packages("ggmap") 
#install.packages("mapproj")
#install.packages("ggplot2")
library(ggmap)
library(mapproj)
library(spdep)
library(maptools)
library(magrittr)
library(dplyr)

shp_file_name="/Users/sary357/Downloads/R_Report/TOWN_MOI_1060831.shp"
data_file_name="/Users/sary357/Downloads/R_Report/stolen_in_taipei_10401_10608.csv"

plot_stolen_in_each_district_in_taipei=function(map_type, data_set, boarder_points, district_name){
  #district_full_name
  plotDf<-data_set %>% select(.,district, lat, lon) %>% filter(.,district==district_name) 
  plot_area<- boarder_points[boarder_points@data$TOWNNAME==district_name,]
  get_map(location = c(lon=median(plotDf$lon),lat=median(plotDf$lat)),
                 source = "google", 
                 zoom = 14,
                 language = "zh-TW", 
                 maptype = map_type) %>% 
  ggmap() +geom_polygon(aes(x = long, y = lat), 
                           data = plot_area,size=0.001, color="black",alpha=0.2)+stat_density2d(data = plotDf, aes(x = lon, y=lat,fill = ..level.., alpha = ..level..),size = 0.01, bins = 16, geom = "polygon") +scale_fill_gradient(low = "green", high = "red",guide = FALSE)+scale_alpha(range = c(0, 0.5), guide = FALSE)
  
  
}

# load data
maptype<-"roadmap"
file_name=data_file_name
stolen_point <- read.csv(file_name)
tw.map <- maptools::readShapeSpatial(shp_file_name)
taipei<-tw.map[tw.map@data$COUNTYNAME=="臺北市",] 

# Taipei: all district
# 台北市全區住宅竊盜熱點圖
map <- get_map(location = c(lon=median(stolen_point$lon),lat=median(stolen_point$lat)),
               source = "google", 
               zoom = 12,
               language = "zh-TW", 
               maptype = maptype)
#ggmap(map) + geom_point(aes(x = lon, y = lat), data = stolen_point,size=1, col="red",alpha=0.6)+stat_density2d(data = stolen_point, aes(x = lon, y=lat,fill = ..level.., alpha = ..level..),size = 0.01, bins = 16, geom = "polygon") +scale_fill_gradient(low = "green", high = "red",guide = FALSE)+scale_alpha(range = c(0, 0.5), guide = FALSE)
ggmap(map) +geom_point(aes(x = long, y = lat), 
                         data = taipei,size=0.001, color="black",alpha=0.1)+stat_density2d(data = stolen_point, aes(x = lon, y=lat,fill = ..level.., alpha = ..level..),size = 0.01, bins = 16, geom = "polygon") +scale_fill_gradient(low = "green", high = "red",guide = FALSE)+scale_alpha(range = c(0, 0.5), guide = FALSE)

# generate according to different districts 
addr<-stolen_point$定位地點
district_lat<-stolen_point$lat
district_lon<-stolen_point$lon
district<-substr(addr, 4, 6)
df<-data.frame("district"=district, "lat"=district_lat, "lon"=district_lon)

# let's plot
# 中山區
district_name='中山區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 中正區
district_name='中正區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 大同區
district_name='大同區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 萬華區
district_name='萬華區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 松山區
district_name='松山區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 大安區
district_name='大安區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 信義區
district_name='信義區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 文山區
district_name='文山區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 南港區
district_name='南港區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 內湖區
district_name='內湖區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 士林區
district_name='士林區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# 北投區
district_name='北投區'
plot_stolen_in_each_district_in_taipei(maptype,df,taipei,district_name)

# get some statistics of each district in Taipei between 201501~201708
df %>% group_by(district) %>% summarise(m=n()) %>% arrange(.,-m)

