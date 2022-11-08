#Assignment 6 script

library(dbplyr)
library(tidyverse)

#Part 1

Toomey_ebird<-read.csv("assignments/assn_6/MBT_ebird.csv")
View(Toomey_ebird)

options(dplyr.summarise.inform = FALSE)
year_count<-Toomey_ebird %>% #reference which file to count data in
  group_by(month, year, location ) %>% #group data by year
  summarise(num_of_speciesy=n())

year_count<-Toomey_ebird %>% #reference which file to count data in
  group_by(month, year, location ) %>% #group data by year
  count(common_name)

year_count2<-year_count %>% #reference which file to count data in
  group_by(month, year, location ) %>% #group data by year
  summarise(num_of_species=n())

head(year_count2)

p1 <-ggplot(data= year_count2)+
  aes(as.factor(month), num_of_species, color = year) +
  geom_point(size =3)+
  facet_wrap(~location)+
  xlab("Month")+
  ylab("number of species")
p1


#Part 2

f3

p2 <-ggplot(data= f3,aes(treatment,mass) )+
  geom_jitter(size =3, aes(treatment, mass, color=gender))+
  xlab("Treatment")+
  ylab("Mass")+
  stat_summary(fun = mean, 
               geom = "crossbar", 
               width = 0.5, 
               color = "red") +
  stat_summary(geom = "errorbar", 
               width = 0.3)
  
p2  


#Part 3

p3 <-ggplot(data= f3,aes(age,mass) )+
  geom_point(size =3, aes(age, mass, color=treatment))+
  xlab("Age")+
  ylab("Mass")+
  geom_smooth(size = 2, method = lm,
            aes(color = treatment,  group = treatment), se=FALSE)

p3


#Part 4
library(patchwork)
p2+p3+
  plot_annotation(tag_levels ='a')+
  plot_annotation('Changes in treatment effects for age and sex')











