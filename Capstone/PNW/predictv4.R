#This is a simple next word prediction model
#Its objective is to deliver an excellent user experience of rapid execution time and reasonable prediction accuracy
#This prediction model is based on ngrams with stupid back off.

predict_next_word <- function(input_text,ngram_models_final)
{
#Determine the number of ngram models used
  library(dplyr)
number_ngram_models <- length(ngram_models_final) 

#Enter the input text, clean it, split the sentence in words and determine the number of words in  the sentence

input_text <- tolower(input_text)
clean_input_text <- iconv(input_text,"latin1","ASCII",sub="")

input_words <- unlist(strsplit(clean_input_text, split=" "))   #words <- unlist(strsplit(line, split=" "))

number_input_words <- length(input_words) #len <- length(words);


#we determine the ngram models that will used based on the number of words in the input_text
if(number_input_words < number_ngram_models)
  {
  used_ngram_models <- number_input_words + 1
  
  used_ngrams <- ngram_models_final[(number_ngram_models-number_input_words):number_ngram_models]
  
}
else
  {
  used_ngram_models <- number_ngram_models
  used_ngrams <- ngram_models_final
}


#When doing prediction, we first look into the highest order model
#if more 2 words are entered we try to predict the next word based on the first three words using quadgrams
#if 2 words are entered we try to predict the next word based on trigrams
#if 1 word is entered we try to predict the next word based on bigrams
for(model in used_ngrams)
{
  
  #We determine pattern we will search using a combination of either the last 3, 2 or 1 word in the input text
  pattern <- paste0("^",paste(input_words[(number_input_words - used_ngram_models + 2):number_input_words],collapse = " ")," ")
  
  
  # Find the pattern in the respective n-gram model
  # Identify the 3 possible pattern matches based on the 3 highest counts
  nextWords <- model[grep(pattern,model$feature)[1:3],1]
  nextWords <- nextWords[!is.na(nextWords)]

  if(length(nextWords) == 0)
    {
    used_ngram_models = used_ngram_models - 1
    next
  }
  if(used_ngram_models == 1)
    {
  break
}

#Separate the predicted next word from the pattern identified in the ngram_model

  predictions <- NULL
  for(word in nextWords)
  {
    tempNextWord <- NULL
    tempNextWord <- unlist(strsplit(as.character(word)," "))
   
    nextWord <- paste(tempNextWord[length(tempNextWord)])
   
    predictions <- c(predictions,nextWord)
    
  }
 break
}
if(length(nextWords) == 0)
  {
  predictions <- c("?")
}
predictions <-matrix(predictions, ncol=1, byrow=TRUE)
predictions <-as.data.frame(predictions, stringsAsFactors = FALSE)
names(predictions) <- NULL
print(predictions)
}


