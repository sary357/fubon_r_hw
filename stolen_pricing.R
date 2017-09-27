install.packages("ggmap") 
install.packages("mapproj")
install.packages("ggplot2")
library(ggmap)
library(mapproj)

# Taipei: all district
file_name="/Users/sary357/Downloads/R報告/stolen_in_taipei_10401_10608.csv"
stolen_point <- read.csv(file_name)
map <- get_map(location = c(lon=median(stolen_point$lon),lat=median(stolen_point$lat)),
               source = "google", 
               zoom = 12,
               language = "zh-TW", 
               maptype = "roadmap")
#ggmap(map) + geom_point(aes(x = lon, y = lat), data = stolen_point,size=1, col="red",alpha=0.6)+stat_density2d(data = stolen_point, aes(x = lon, y=lat,fill = ..level.., alpha = ..level..),size = 0.01, bins = 16, geom = "polygon") +scale_fill_gradient(low = "green", high = "red",guide = FALSE)+scale_alpha(range = c(0, 0.5), guide = FALSE)
# 台北市全區住宅竊盜熱點圖
ggmap(map) +stat_density2d(data = stolen_point, aes(x = lon, y=lat,fill = ..level.., alpha = ..level..),size = 0.01, bins = 16, geom = "polygon") +scale_fill_gradient(low = "green", high = "red",guide = FALSE)+scale_alpha(range = c(0, 0.5), guide = FALSE)

# generate according to different districts 
addr<-stolen_point$定位地點
district_lat<-stolen_point$lat
district_lon<-stolen_point$lon
district<-substr(addr, 1, 6)
df<-data.frame("district"=district, "lat"=district_lat, "lon"=district_lon)
library(magrittr)
library(dplyr)
df$district
df_1<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市中山區') 
df_2<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市中正區') 
df_3<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市大同區') 
df_4<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市萬華區') 
df_5<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市松山區') 
df_6<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市大安區') 
df_7<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市信義區') 
df_8<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市文山區') 
df_9<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市南港區') 
df_10<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市內湖區') 
df_11<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市士林區')
df_12<-df %>% select(.,district, lat, lon) %>% filter(.,district=='台北市北投區')

# df_1: 台北市中山區
map <- get_map(location = c(lon=median(df_1$lon),lat=median(df_1$lat)),
               source = "google", 
               zoom = 14,
               language = "zh-TW", 
               maptype = "roadmap")
ggmap(map) +stat_density2d(data = df_1, aes(x = lon, y=lat,fill = ..level.., alpha = ..level..),size = 0.01, bins = 16, geom = "polygon") +scale_fill_gradient(low = "green", high = "red",guide = FALSE)+scale_alpha(range = c(0, 0.5), guide = FALSE)

# df_3: 台北市大同區
map <- get_map(location = c(lon=median(df_3$lon),lat=median(df_3$lat)),
               source = "google", 
               zoom = 14,
               language = "zh-TW", 
               maptype = "roadmap")
ggmap(map) +stat_density2d(data = df_3,
                           aes(x = lon, y=lat,fill = ..level.., alpha = ..level..),
                           size = 0.01, bins = 16, geom = "polygon") +scale_fill_gradient(low = "green", high = "red",guide = FALSE)+scale_alpha(range = c(0, 0.5), guide = FALSE)

# df_4: 台北市萬華區
map <- get_map(location = c(lon=median(df_4$lon),lat=median(df_4$lat)),
               source = "google", 
               zoom = 14,
               language = "zh-TW", 
               maptype = "roadmap")
ggmap(map) +stat_density2d(data = df_4, aes(x = lon, y=lat,fill = ..level.., alpha = ..level..),size = 0.01, bins = 16, geom = "polygon") +scale_fill_gradient(low = "green", high = "red",guide = FALSE)+scale_alpha(range = c(0, 0.5), guide = FALSE)

# df_5: 台北市松山區
map <- get_map(location = c(lon=median(df_5$lon),lat=median(df_5$lat)),
               source = "google", 
               zoom = 14,
               language = "zh-TW", 
               maptype = "roadmap")
ggmap(map) +stat_density2d(data = df_5, aes(x = lon, y=lat,fill = ..level.., alpha = ..level..),size = 0.01, bins = 16, geom = "polygon") +scale_fill_gradient(low = "green", high = "red",guide = FALSE)+scale_alpha(range = c(0, 0.5), guide = FALSE)


# df_7: 台北市信義區
map <- get_map(location = c(lon=median(df_7$lon),lat=median(df_7$lat)),
               source = "google", 
               zoom = 14,
               language = "zh-TW", 
               maptype = "roadmap")
ggmap(map) +stat_density2d(data = df_7, aes(x = lon, y=lat,fill = ..level.., alpha = ..level..),size = 0.01, bins = 16, geom = "polygon") +scale_fill_gradient(low = "green", high = "red",guide = FALSE)+scale_alpha(range = c(0, 0.5), guide = FALSE)
