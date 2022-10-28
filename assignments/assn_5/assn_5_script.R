# libraries
library(dbplyr)
library(tidyverse)

#import files
f1<-read_csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/assignment6part1.csv?raw=true")
f2<-read_csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/assignment6part2.csv?raw=true")

View(f1)
View(f2)
View(f3)
View(f1_pivot)
View(f2_pivot)
View(f3_transpose)

#Part 1


#sort samples in F1 into male and female
f1_pivot<-f1 %>% 
  pivot_longer(
    col = !ID, #pivot columns that are not family
    names_to = c(".value", "gender"), #transform column names to two variables. The special name ".value" tells pivot_longer() that that part of the column name specifies the “value” being measured (which will become a variable in the output) 
    names_sep = "_", #This tells pivot_longer() to split the column names at the "_". 
    values_drop_na = TRUE,
  )

#sort samples in F2 by treatment
f2_pivot<-f2 %>% 
  pivot_longer(
    col = !ID, #pivot columns that are not family
    names_to = c(".value", "treatment"), #transform column names to two variables. The special name ".value" tells pivot_longer() that that part of the column name specifies the “value” being measured (which will become a variable in the output) 
    names_sep = c("\\."), #This tells pivot_longer() to split the column names at the "_". 
    values_drop_na = TRUE
  )

#join the two tables together
f3<-f1_pivot %>% 
  full_join(f2_pivot)

#Part 2

#transposing the data
f3_transpose<-tibble(#make sure data frame remains a tibble
  t(f3)) #transpose the data

#turning transposed data back into a tibble
is_tibble(f3_transpose)

View(f3_transpose)

head(f3_transpose)
f3_transpose$residual_mass<-f3_transpose$`t(f3)`[5]/f3_transpose$`t(f3)`[1]



















