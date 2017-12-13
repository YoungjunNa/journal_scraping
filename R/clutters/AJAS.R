##Scraping the data from Scientific Journals
#Author: Youngjun Na
#Email: ruminoreticulum@gmail.com
#Github: https://github.com/YoungjunNa
#Date: 11/2/2017

library(rvest)
library(dplyr)
library(stringr)

#URL list
setwd("D:/GitHub/journal_scraping") #set working directory
list <- readxl::read_excel("journal_URL.xlsx") #set URL list
list <- filter(list, journal == "AJAS") #filtering the journal

#data.frame
AJAS_result<-list
AJAS_result<-cbind(AJAS_result, subject=NA)
AJAS_result<-cbind(AJAS_result, first_author=NA)

n<-nrow(list)

for(i in 0:(n-1)){
  nb=i+1
  url <- list$URL[nb]
  html <- read_html(url, encoding="UTF-8")

  #Subject
  subject<-html %>% html_nodes(".PubTitle") %>% html_text()  

  #1st author
  first_author<-html %>% html_node(xpath="//div[3]/div/div[7]") %>% html_children() %>% html_text() 
  first_author <- first_author[1]
  first_author <- gsub(" ","",first_author)
  
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    AJAS_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    AJAS_result$first_author[nb]<-first_author[1]
  }
  
}

#write.csv
write.csv(AJAS_result,"AJAS_result.txt",row.names = FALSE)


