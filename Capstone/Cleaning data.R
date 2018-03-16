## Using dtplyr package for this project.
## dtplyr implements the data table back-end for 'dplyr' so that you can seamlessly use data table and 'dplyr' together.

library(dtplyr)
library(dplyr)
library(stringi)
library(knitr)
library(kableExtra)
library(quanteda)
library(readtext)
library(ggplot2)

## Determine filesizes in Millions

blogssize<-file.size("/Users/jvanstee/datasciencecoursera/Capstone/final/en_US/en_US.blogs.txt")/1024^2

newssize<-file.size("/Users/jvanstee/datasciencecoursera/Capstone/final/en_US/en_US.news.txt")/1024^2

twittersize<-file.size("/Users/jvanstee/datasciencecoursera/Capstone/final/en_US/en_US.twitter.txt")/1024^2

##Read files
con <- file("/Users/jvanstee/datasciencecoursera/Capstone/final/en_US/en_US.blogs.txt")
blogs <- readLines(con)
close(con)

con <- file("/Users/jvanstee/datasciencecoursera/Capstone/final/en_US/en_US.news.txt")
news <- readLines(con)
close(con)

con <- file("/Users/jvanstee/datasciencecoursera/Capstone/final/en_US/en_US.twitter.txt")
twitter <- readLines(con, skipNul = TRUE)
close(con)


# Numbers of lines in the files in Millions
blogslength<-length(blogs)/1024^2

newslength<-length(news)/1024^2

twitterlength<-length(twitter)/1024^2


# Number of words in each file in Millions
blogswords <-sum(stri_count_words(blogs))/1024^2

newswords <-sum(stri_count_words(news))/1024^2

twitterwords <-sum(stri_count_words(twitter))/1024^2

table <- data.frame(file = c("USblogs", "USnews", "US twitter"), size = c(blogssize,newssize,twittersize),
                    length  = c(blogslength,newslength,twitterlength), words = c(blogswords,newswords,twitterwords))
table %>% kable("html") %>% kable_styling()

#clean up memory
rm(blogs,news,twitter)