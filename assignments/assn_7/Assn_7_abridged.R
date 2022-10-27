# Assn 7 abridged
## This code creates a map and a figure based on 10 selected points on the map and climate data
## Code from GIS lesson but does not output any maps apart from the map of my world and the final graph

#load libraries
library(sp) # classes for vector data (polygons, points, lines)
library(rgdal) # basic operations for spatial data
library(raster) # handles rasters
library(rgeos) # methods for vector files
library(geosphere)
library(dismo)


#select the maps with the data of the three climate parameters

my_clim_stack <- stack(
  raster('assignments/assn_7/WORLDCLIM_Rasters/wc2.1_10m_bio_1.tif'),
  raster('assignments/assn_7/WORLDCLIM_Rasters/wc2.1_10m_bio_4.tif'),
  raster('assignments/assn_7/WORLDCLIM_Rasters/wc2.1_10m_bio_17.tif')
)

names(my_clim_stack) <- c("Annual_Mean_Temperature", "Temperature_Seasonality", "Precip_Driest_Quarter")


#plot one of the climate maps to select points from

plot(my_clim_stack[[3]]) 


#pick points to model our climate niche

my_sites<-as.data.frame(click(n=10)) #allows you to click points on the map

#add labels to the my_sites data frame
names(my_sites)<- c("longitude", "latitude")

#create a data frame that extracts the climate data for selected sites
env <- as.data.frame(extract(my_clim_stack, my_sites))

#combine location data from sites and the climate data for sites
my_sites <- cbind(my_sites, env)

# generate set of random points for comparison to selected locations
bg<-as.data.frame(randomPoints(my_clim_stack, n=10000))

#name columns for random points
names(bg)<-c("longitude", "latitude")

#extract climate data for random points
bgEnv<- as.data.frame(extract(my_clim_stack, bg))

#combine location data from sites and the climate data for random sites
bg<-cbind(bg, bgEnv)

#train the model 

#code my sites as 1's and random sites as 0's
pres_bg<-c(rep(1, nrow(my_sites)), rep(0,nrow(bg)))

#make train dataframe by combining information from previous dataframes
train_data<- data.frame(pres_bg = pres_bg, 
                        rbind (my_sites, bg))

#the model

my_model<- glm(pres_bg ~Annual_Mean_Temperature*Temperature_Seasonality*Precip_Driest_Quarter+
                 I(Annual_Mean_Temperature^2)+ I(Temperature_Seasonality^2)+
                 I(Precip_Driest_Quarter^2),
               data = train_data,
               family="binomial",
               weights =c(rep(1, nrow(my_sites)), rep(nrow(my_sites)/nrow(bg), nrow(bg)))
)

#use model to predict climate niche

my_world<- predict(
  my_clim_stack,
  my_model,
  type="response"
)


#plot my world 

plot(my_world)
points(my_sites, bg='blue2', col='blue2',  pch=20)

#threshold preferred regions
my_world_thresh <- my_world >= quantile(my_world, 0.75)

# convert all values not equal to 1 to NA...
# using "calc" function to implement a custom function
my_world_thresh <- calc(my_world_thresh, fun=function(x) ifelse(x==0 | is.na(x), NA, 1))

# get random sites from within my world threshhold
my_best_sites <- randomPoints(my_world_thresh, 10000) #random sites are selected from your world
my_best_env <- as.data.frame(extract(my_clim_stack, my_best_sites))

# plot world's climate

#create scatterplot of random points from whole world with two selected climate variables
smoothScatter(x=bgEnv$Annual_Mean_Temperature, y=bgEnv$Precip_Driest_Quarter, col='lightblue', xlab = "Annual Mean Temperature (C)", ylab = "Precipitation Driest Quater")
#add the random points from my thershhold
points(my_best_env$Annual_Mean_Temperature, my_best_env$Precip_Driest_Quarter, col='red', pch=16, cex=0.2)
#add the points that I selected
points(my_sites$Annual_Mean_Temperature, my_sites$Precip_Driest_Quarter, pch=16)
#add legend
legend(
  'topleft',
  inset=0.01,
  legend=c('world', 'my niche', 'my locations'),
  pch=16,
  col=c('lightblue', 'red', 'black'),
  pt.cex=c(1, 0.4, 1)
)







