# libraries
library(dbplyr)
library(tidyverse)

#import files



#Part 1
f1<-read_csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/assignment6part1.csv?raw=true")
f2<-read_csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/assignment6part2.csv?raw=true")

f1_pivot<-f1 %>% 
  pivot_longer(cols = !ID, names_to = "Sample", values_to = c("Value"))

f2_pivot<-f2 %>% 
  pivot_longer(cols = !ID, names_to = "Sample", values_to = c("Value"))


f3<-full_join(f1_pivot,f2_pivot)



#pivot practice
relig_income

relig_income %>% 
  pivot_longer(cols = c("<$10k", "$10-20k", "$20-30k", "$30-40k", 
                        "$40-50k", "$50-75k", "$75-100k", "$100-150k", ">150k", "Don't know/refused"), 
               names_to = "income", values_to = "count")
relig_income %>% 
  pivot_longer(cols = "<$10k":"Don't know/refused", names_to = "income", values_to = "count")

relig_income %>% 
  pivot_longer(cols = !religion, names_to = "income", values_to = "count")

billboard

billboard %>% 
  pivot_longer(
    cols = starts_with("wk"), #pivot all columns with names beginning with "wk"
    names_to = "week", #convert column names to a variable called week
    values_to = "rank", #reorganize observations in each column into a variable called rank
    values_drop_na = TRUE #drop NAs from the pivoted data set
  )

billboard %>% 
  pivot_longer(
    cols = starts_with("wk"), #pivot all columns with names beginning with "wk"
    names_to = "week", #convert column names to a variable called week
    names_prefix = "wk", #this command strips off the "wk" prefie from the column name
    names_transform = list(week = as.integer), #this option transforms the variable type from a string to integer
    values_to = "rank", #reorganize observations in each column into a variable called rank
    values_drop_na = TRUE, #drop NAs from the pivoted data set
  )
