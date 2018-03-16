## Using dtplyr package for this project.
## dtplyr implements the data table back-end for 'dplyr' so that you can seamlessly use data table and 'dplyr' together.

library(dtplyr)


##Read English training data
enUSblogs <- read.table("./Capstone/final/en_US/en_US.blogs.txt", header = FALSE, fill = TRUE)
enUSnews <- read.table("./Capstone/final/en_US/en_US.news.txt", header = FALSE, fill = TRUE)
enUStwitter <- read.table("./Capstone/final/en_US/en_US.twitter.txt", header = FALSE, fill = TRUE)

## Question 1 - Filesize of USblogs.txt file?
enUSblogsINFO <- file.info("./Capstone/final/en_US/en_US.blogs.txt")
enUSblogsINFO$size

## Question 2 - Number of lines in UStwitter.txt file?
enUStwitter <- readLines(file("./Capstone/final/en_US/en_US.twitter.txt"), encoding = "UTF-8", skipNul = TRUE)
close(enUStwitter)
length(enUStwitter)


##Question 3 - What is the length of the longest line seen in any of the three en_US data sets?
enUSblogs<-file("./Capstone/final/en_US/en_US.blogs.txt")
enUSblogsLINES <-readLines(enUSblogs, encoding = "UTF-8", skipNul = TRUE)
close(enUSblogs)
summary(nchar(enUSblogsLINES))

enUSnews<-file("./Capstone/final/en_US/en_US.news.txt")
enUSnewsLINES <-readLines(enUSnews, encoding = "UTF-8", skipNul = TRUE)
close(enUSnews)
summary(nchar(enUSnewsLINES))

enUStwitter<-file("./Capstone/final/en_US/en_US.twitter.txt")
enUStwitterLINES <-readLines(enUStwitter, encoding = "UTF-8", skipNul = TRUE)
close(enUStwitter)
summary(nchar(enUStwitterLINES))

##Question 4 - In the en_US twitter data set, if you divide the number of lines where the word "love" (all lowercase) occurs by the number of lines the word "hate" (all lowercase) occurs, about what do you get?
enUStwitter <- file("./Capstone/final/en_US/en_US.twitter.txt")
enUStwitterLOVE <- grepl(".love.", readLines(enUStwitter), ignore.case = FALSE)
sum(enUStwitterLOVE)

enUStwitterHATE <- grepl(".hate.", readLines(enUStwitter), ignore.case = FALSE)
sum(enUStwitterHATE)

RatioLOVEtoHATE <- sum(enUStwitterLOVE)/sum(enUStwitterHATE)

##Question 5 - The one tweet in the en_US twitter data set that matches the word “biostats” says what?
enUStwitterLINES <- readLines(enUStwitter)
enUStwitterLINES[grepl(".biostats.", enUStwitterLINES, ignore.case = FALSE) ==TRUE]

##Question 6 - How many tweets have the exact characters “A computer once beat me at chess, but it was no match for me at kickboxing”. (I.e. the line matches those characters exactly.)
enUStwitterLINES[grepl("A computer once beat me at chess, but it was no match for me at kickboxing", enUStwitterLINES, ignore.case = FALSE) ==TRUE]