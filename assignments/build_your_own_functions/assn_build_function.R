#build your own function assn

#load libraries
library(dplyr)
library(tidyverse)

# import dataset

Toomey_ebird<-read.csv("assignments/build_your_own_functions/MBT_ebird.csv")
View(Toomey_ebird)


#Problem 1

#create function
bird_call<-function(sci_name){
  bird<-Toomey_ebird %>% #create a data frame with information from the ebird file
    filter(scientific_name == sci_name) #filter out a specific scientific name
  write_csv(bird,paste0("assignments/build_your_own_functions/",sci_name,".csv")) #write a file to a csv
}

#create list of all the things to put into the function
birds=c("Anser caerulescens", "Antrostomus carolinensis", "Setophaga americana")

#loop the list through the function
for (item in birds){
  bird_call(item)
}


#Problem 2

#Create a function

Most_and_least_df<-NULL

Most_and_least<-function(file_name){
  bird_count<-read.csv(paste0("assignments/build_your_own_functions/",file_name,".csv"))
  max_obs=slice_max(bird_count, count)
  head_max_obs=slice_head(max_obs)
  min_obs=slice_min(bird_count, count)
  head_min_obs=slice_head(min_obs)
  Most_and_least_df<-rbind(Most_and_least_df,head_max_obs, head_min_obs)
  assign('Most_and_least_df',Most_and_least_df,envir=.GlobalEnv)
}

for (item in birds){
  Most_and_least(item)
}

write_csv(Most_and_least_df,("assignments/build_your_own_functions/Most_and_Least.csv"))

#Problem 3

birds2=c("Branta canadensis", "Spatula discors", "Anas platyrhynchos")
Most_and_least_df<-NULL

fun_combine<-function(species){
  bird_call(species)
  Most_and_least(species)
}

for (item in birds2){
  fun_combine(item)
}

write_csv(Most_and_least_df,("assignments/build_your_own_functions/Most_and_Least_problem3.csv"))






