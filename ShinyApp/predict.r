quadgram <- readRDS(file = ".//quadgram.RData")
trigram <- readRDS(file = ".//trigram.RData")
bigram <- readRDS(file = ".//bigram.RData")

clean<-function(x){
  y <- tolower(x)
  y <- removePunctuation(y)
  y <- removeNumbers(y)
  y <- str_replace_all(y, "[^[:alnum:]]", " ")
  y <- stripWhitespace(y)
  return(y)
}

callingClean<- function(x){
  y <- clean(x)
  y<- txt.to.words.ext(y, corpus.lang = "English.all", preserve.case = TRUE)
  return(y)
}

# prediction function
getNextWord <- function(wCount,userInput){
  # if the user enters more than three words, use only the last three words entered
  if (wCount >= 3) {
    userInput <- userInput[(wCount-2):wCount] 
    # user enters two words, make first word in vector NA 
  } else if (wCount == 2) {
    userInput <- c(NA,userInput)   
    # user enters one word, make first two in vector NA
  } else if (wCount == 1) {
    userInput <- c(NA,NA,userInput)
  }
  
  # select next word based on user input from quadgram, trigram, and bigram dataframes
  nextWords <- as.character(quadgram[quadgram$unigram==userInput[1] & 
                                       quadgram$bigram==userInput[2] & 
                                       quadgram$trigram==userInput[3],][1,]$quadgram)
  
  if(is.na(nextWords)) {
    nextWords <- as.character(trigram[trigram$unigram==userInput[2] & 
                                        trigram$bigram==userInput[3],][1,]$trigram)
    
    if(is.na(nextWords)) {
      nextWords <- as.character(bigram[bigram$unigram==userInput[3],][1,]$bigram)
    }
  }
 
  cat(nextWords)
  
}
