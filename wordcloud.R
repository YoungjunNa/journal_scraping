

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

setwd("D:/GitHub/journal_scraping") #set working directory
wc <- read.csv("JDS_result.txt", stringsAsFactors = FALSE)

#WORDCLOUD
wc <- Corpus(VectorSource(wc$subject))

inspect(wc)

wc_data<-tm_map(wc,stripWhitespace)
wc_data<-tm_map(wc_data, tolower)
wc_data<-tm_map(wc_data,removeNumbers)
#wc_data<-tm_map(wc_data, removePunctuation)
wc_data<-tm_map(wc_data, removeWords, stopwords("english"))
wc_data<-tm_map(wc_data,removeWords, c("affect","effect","effects","and","the","our","that","for","are","also","more","has","must","have","should","this","with"))

tdm_wc<-TermDocumentMatrix(wc_data) #Creates a TDM
TDM1<-as.matrix(tdm_wc) #Convert this into a matrix format
v = sort(rowSums(TDM1), decreasing = TRUE) #Gives you the frequencies for every word

wordcloud(wc_data, max.words = 100, min.freq = 1, random.order = FALSE, rot.per = 0.1, colors = brewer.pal(8, "Dark2"))


## Term-Document
dtm <- TermDocumentMatrix(wc_data)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word, col ="lightblue", main ="Most frequent words", ylab = "Word frequencies")

