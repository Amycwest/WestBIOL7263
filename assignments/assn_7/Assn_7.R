# generate two different maps and 

#maps=matrixes

#raster file (each pixel is a specific value)
#shape value (defines borders around pixels)
#developing a species distribution file

library(sp) # classes for vector data (polygons, points, lines)
library(rgdal) # basic operations for spatial data
library(raster) # handles rasters
library(rgeos) # methods for vector files
library(geosphere)
library(dismo)


#load a raster
bio1<- raster("assignments/assn_7/WORLDCLIM_Rasters/wc2.1_10m_bio_1.tif")

#View data as both a map and a dataframe
plot(bio1) #map
bio1 #data frame

#edit data frame and present it
bio1_f <- bio1 * (9/5)+32 #edit data frame
plot(bio1_f) #plot new data (note change in legend to farenheit)

bio1_f

clim_stack<- stack(list.files("assignments/assn_7/WORLDCLIM_Rasters", full.names = TRUE, pattern=".tif"))

clim_stack

plot(clim_stack[[4]]) #plot an individual map in the clim_stack

my_clim_stack <- stack(
  raster('assignments/assn_7/WORLDCLIM_Rasters/wc2.1_10m_bio_1.tif'),
  raster('assignments/assn_7/WORLDCLIM_Rasters/wc2.1_10m_bio_4.tif'),
  raster('assignments/assn_7/WORLDCLIM_Rasters/wc2.1_10m_bio_17.tif')
)

names(my_clim_stack) <- c("Annual_Mean_Temperature", "Temperature_Seasonality", "Precip_Driest_Quarter")

plot (my_clim_stack)



#plot bivariate relationships among climate variables

pairs(my_clim_stack)

plot(my_clim_stack[[3]]) 


#pick points to model our climate niche

my_sites<-as.data.frame(click(n=10)) #allows you to click points on the map

names(my_sites)<- c("longitude", "latitude")
my_sites

env <- as.data.frame(extract(my_clim_stack, my_sites))
env

my_sites <- cbind(my_sites, env)
my_sites

# generate set of random points for comparison to selected locations

bg<-as.data.frame(randomPoints(my_clim_stack, n=10000))
head(bg)

names(bg)<-c("longitude", "latitude")
head(bg)
plot(my_clim_stack[[3]])
plot(bg, pch='.')

bgEnv<- as.data.frame(extract(my_clim_stack, bg))
head(bgEnv)

bg<-cbind(bg, bgEnv)
head(bg)

#train the model 

pres_bg<-c(rep(1, nrow(my_sites)), rep(0,nrow(bg)))
pres_bg

train_data<- data.frame(pres_bg = pres_bg, 
                        rbind (my_sites, bg))
head(train_data)

#the model

my_model<- glm(pres_bg ~Annual_Mean_Temperature*Temperature_Seasonality*Precip_Driest_Quarter+
                 I(Annual_Mean_Temperature^2)+ I(Temperature_Seasonality^2)+
                 I(Precip_Driest_Quarter^2),
               data = train_data,
               family="binomial",
               weights =c(rep(1, nrow(my_sites)), rep(nrow(my_sites)/nrow(bg), nrow(bg)))
               )
summary(my_model)

#use model to predict climate niche

my_world<- predict(
  my_clim_stack,
  my_model,
  type="response"
)

my_world


#plot my world 

plot(my_world)
points(my_sites, bg='blue2', col='blue2',  pch=20)

#save your world
writeRaster(my_world, "assignments/assn_7/My_climate_space/my_world", 
            format="GTiff", overwrite=TRUE, progress ="text")

#threshold preferred regions
my_world_thresh <- my_world >= quantile(my_world, 0.75)
plot(my_world_thresh)

# convert all values not equal to 1 to NA...
# using "calc" function to implement a custom function
my_world_thresh <- calc(my_world_thresh, fun=function(x) ifelse(x==0 | is.na(x), NA, 1))

# get random sites
my_best_sites <- randomPoints(my_world_thresh, 10000) #random sites are selected from your world
my_best_env <- as.data.frame(extract(my_clim_stack, my_best_sites))

# plot world's climate
smoothScatter(x=bgEnv$Annual_Mean_Temperature, y=bgEnv$Precip_Driest_Quarter, col='lightblue', xlab = "Annual Mean Temperature (C)", ylab = "Precipitation Driest Quater")
points(my_best_env$Annual_Mean_Temperature, my_best_env$Precip_Driest_Quarter, col='red', pch=16, cex=0.2)
points(my_sites$Annual_Mean_Temperature, my_sites$Precip_Driest_Quarter, pch=16)
legend(
  'topleft',
  inset=0.01,
  legend=c('world', 'my niche', 'my locations'),
  pch=16,
  col=c('lightblue', 'red', 'black'),
  pt.cex=c(1, 0.4, 1)
)
