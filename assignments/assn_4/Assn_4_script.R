#load the necessary library packages
library (dplyr)
library(tidyverse)

#turn the csv file into a tibble
Toomey_ebird<-read.csv("~/Documents/School/Biol7263/WestBIOL7263/assignments/assn_4/MBT_ebird.csv")
View(Toomey_ebird)

#count the occurrences of each year in the eBird data and sort it so the year with the most observations is on top
year_count<-Toomey_ebird %>% count(year, sort=TRUE)

year_count<-Toomey_ebird %>% #reference which file to count data in
  group_by(year) %>% #group data by year
  summarize(total=sum(count)) #add the count data and give the total for each year

View(year_count)

#Problem 2

Species_2014<-Toomey_ebird %>% #create a data frame with information from the ebird file
  filter(year == 2014) %>% #only use birds from 2014
  count(common_name)  #list all the common names of birds 

nrow(Species_2014) #list the number of rows in the above data frame

#Problem 3

RWBL<-Toomey_ebird %>% #create a data frame with information from the ebird file
  filter(common_name == "Red-winged Blackbird") %>% #only use Red-winged Blackbirds
  count(location, sort = TRUE)  #count the number of observations for each location and sort so the highest is on the top

View(RWBL)

#Problem 4

time_filter<-Toomey_ebird %>%#create a data frame with information from the ebird file
  filter(duration > 5) %>% #in the data frame put only birds with a duration greater than 5
  filter(duration < 200)#in the data frame put only birds with a duration less than 200
 
species_day<-time_filter%>% #create a data frame with information from filtered file we just created
  group_by(year,list_ID)%>% #group by year and date, the year is redundant but we will need that information for later
  count(common_name) #list the species observed on each day

options(dplyr.summarise.inform = FALSE)#some code to make sure the summarize command is counting the smaller group

species_perday<-species_day%>% #create a data frame with information from filtered file we just created
  group_by(year,list_ID)%>% #group by year and date, the year is redundant but we will need that information for later
  summarise(species_per_day=n()) #count the number of rows for each day, which is equal to the number of species

duration_perday<-time_filter%>% #create a data frame with information from grouped file 
  group_by(year,list_ID)%>% #group by year and date, the year is redundant but we will need that information for later
  summarise(duration=mean(duration)) #give the average duration of time for each day, which bears the question did Dr.Toomey ever have more than one checklist per day?

duration_year<-merge(duration_perday,species_perday) #merge the checklists with the species per day and duration per day
duration_year$species_per_min<-duration_year$species_per_day/duration_year$duration #add a variable to the merged checklist that divides species by duration

duration_year%>%  # use the data frame we just created
  group_by(year) %>% # group the data frame by year
  summarise(average_species_per_minute= mean(species_per_min)) #take an average of the mean species per minute for each year


# problem 5

top_10<-Toomey_ebird%>% #create a new data frame and reference which data frame you're creating it from
  count (common_name)%>% #count the occurrence of each common name
  arrange(by=(desc(n))) #sort by the count from greatest to least
top_10_dataframe<-as.list(top_10$common_name[1:10]) #create a list from the top 10 birds 

top_10_tibble<- as_tibble(Toomey_ebird%>% #create a tibble
  filter(common_name==Top_10_list)) #filter based off the species in the list

#write tibble to a .csv
write_csv(top_10_tibble, "~/Documents/School/Biol7263/WestBIOL7263/assignments/assn_4/Toomey_top_10.csv")

  