#for loops

for (i in 1:5){
  print(i)
}

animal_list<-c("fish", "birds", "more birds")

for (i in animal_list){
  cat(i, "\n")
}


all_words =c ("bikes", "biology", "coffee", "serendipity")

for (word in all_words){
  
  sentence= paste0("There are ", nchar(word), " characters in the word ", word,".")
  cat(sentence)
}


all_nums=c(10,12,28,34,NA,NA,11,11)

even_nums=NULL
odd_nums=NULL
for (n in all_nums) {
  if (is.na(n)== T)
    {next}
  if ((n %% 2) == 0){
    even_nums = c(even_nums, n)
  } else{
    odd_nums=c(odd_nums, n)
  }
}
odd_nums
even_nums













