#build your own function assn

#load libraries
library("dplyr")

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
birds=c("Antrostomus carolinensis","Anser caerulescens", "Setophaga americana")

#loop the list through the function
for (birds in birds){
  bird_call(birds)
}

#Problem 2

#Create a function
Most_and_least_df<-data.frame(NULL)

Most_and_least<-function(file_name){
  bird_count<-read.csv(paste0("assignments/build_your_own_functions/",file_name))
  max_obs=slice_max(bird_count, count)
  min_obs=slice_min(bird_count, count)
  Most_and_least_df<-rbind(Most_and_least_df, min_obs, max_obs)
}


for (birds in birds){
  Most_and_least(birds)
}

















