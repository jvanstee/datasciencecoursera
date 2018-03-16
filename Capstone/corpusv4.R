
#determine the number of lines to sample in each file
p <- .15  # we're going with a sample containing 15% of the texts


##Read a sample English training data
con <- file("/Users/jvanstee/datasciencecoursera/Capstone/final/en_US/en_US.blogs.txt")
blogs_sample <- readLines(con,blogslength*1024^2*p)
close(con)

con <- file("/Users/jvanstee/datasciencecoursera/Capstone/final/en_US/en_US.news.txt")
news_sample <- readLines(con,newslength*1024^2*p)
close(con)

con <- file("/Users/jvanstee/datasciencecoursera/Capstone/final/en_US/en_US.twitter.txt")
twitter_sample <- readLines(con, twitterlength*1024^2*p,skipNul = TRUE)
close(con)

data_sample <- c(blogs_sample,news_sample,twitter_sample)
#data_sample <- c(blogs_sample,news_sample)

# read file with profanity words that we want to remove from the corpus
profanity <- readLines(file("/Users/jvanstee/datasciencecoursera/Capstone/Terms-to-Block.csv",encoding = "UTF-8"),encoding = "UTF-8")

# build a corpus with quanteda
mycorpus <- corpus(data_sample)

mycorpus_tokenized <- tokens(mycorpus,remove_punct = TRUE, remove_numbers = TRUE, remove_separators = TRUE, what = "word")
#mycorpus_tokenized <- tokens_remove(tokens(mycorpus,remove_punct = TRUE, remove_numbers = TRUE, remove_separators = TRUE, what = "word"), stopwords("english"))

# create ngrams

ngram1 <- tokens_ngrams(mycorpus_tokenized, n = 1, skip = 0L)
ngram2 <- tokens_ngrams(mycorpus_tokenized, n = 2, skip = 0L, concatenator = " ")
ngram3 <- tokens_ngrams(mycorpus_tokenized, n = 3, skip = 0L, concatenator = " ")
ngram4 <- tokens_ngrams(mycorpus_tokenized, n = 4, skip = 0L, concatenator = " ")

dfm_ngram1<-dfm(ngram1, remove = c(profanity,stopwords("english"))) # remove english stopwords and profanity
ngram1_freq <- textstat_frequency(dfm_ngram1)

dfm_ngram2<-dfm(ngram2)
ngram2_freq <- textstat_frequency(dfm_ngram2)

dfm_ngram3 <- dfm(ngram3)
ngram3_freq <- textstat_frequency(dfm_ngram3)

dfm_ngram4 <- dfm(ngram4)
ngram4_freq <- textstat_frequency(dfm_ngram4)
  

#remove ngrams with less than 2 occurences in the model
ngram1_clean <- as.data.frame(ngram1_freq)
#ngram1_clean <- ngram1_df %>% filter(frequency >= 5)
head(ngram1_clean)

ngram2_df <- as.data.frame(ngram2_freq)
ngram2_clean <- ngram2_df %>% filter(frequency >= 2)
head(ngram2_clean)

ngram3_df <- as.data.frame(ngram3_freq)
ngram3_clean <- ngram3_df %>% filter(frequency >= 2)
head(ngram3_clean)

ngram4_df <- as.data.frame(ngram4_freq)
ngram4_clean <- ngram4_df %>% filter(frequency >= 2)
head(ngram4_clean)

ngram_models <- list(ngram4_clean, ngram3_clean,ngram2_clean,ngram1_clean) 
#ngram_models <- list(ngram4_clean, ngram3_clean,ngram2_clean) 

rm(blogs_sample,news_sample,twitter_sample)
rm(dfm_ngram1,dfm_ngram2,dfm_ngram3,dfm_ngram4)
rm(ngram1_freq,ngram2_freq,ngram3_freq,ngram4_freq)
rm(ngram2_df,ngram3_df,ngram4_df)
rm(ngram1,ngram2,ngram3,ngram4)

saveRDS(ngram_models,"Capstone/PNW/data/ngram_models.rds")