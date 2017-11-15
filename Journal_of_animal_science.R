##Scraping the data from Scientific Journals
#Author: Youngjun Na
#Email: ruminoreticulum@gmail.com
#Github: https://github.com/YoungjunNa
#Last update: 11/15/2017

library(rvest)
library(dplyr)
library(stringr)
library(lubridate)

#URL list
setwd("D:/GitHub/journal_scraping") #set working directory
list <- readxl::read_excel("journal_URL.xlsx") #set URL list
list <- filter(list, journal == "journal of animal science") #filtering the journal

#data.frame
JAS_result<-list
JAS_result<-cbind(JAS_result, subject=NA)
JAS_result<-cbind(JAS_result, keywords=NA)
JAS_result<-cbind(JAS_result, corresponding=NA)

n<-nrow(list)

url <- "https://www.animalsciencepublications.org/publications/jas/articles/95/11/5064"

for(i in 0:(n-1)){
  nb=i+1
  url <- list$URL[nb]
  html <- read_html(url, encoding="UTF-8")

  #Subject
  subject<-html %>% html_nodes(xpath="//div/h1/text()") %>% html_text()  
  
  #keywords
  keywords<-html %>% html_nodes(".kwd-group") %>% html_text()  
  keywords<-gsub(";","",keywords)
  keywords<-gsub("\n\t","",keywords)
  
  #corresponding_author
  corresponding<-html %>% html_node(".fn-corresp") %>% html_children() %>% .[[2]] %>% html_text() 
  
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    JAS_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(keywords),integer(0)) != TRUE){
    JAS_result$keywords[nb] <- keywords
  }
  
  if(all.equal(nchar(corresponding),integer(0)) != TRUE){
    JAS_result$corresponding[nb]<-corresponding
  }
}

#write.csv
write.csv(JAS_result,"JAS_result.txt",row.names = FALSE)

##history
#history<-data.frame(recieved=recieved,accepted=accepted,published=published, corresponding=NA)
#history<-html %>% html_nodes(".history-list") %>% html_children() %>% html_text() 
#recieved<-gsub(",","",str_sub(history[1],start=11)) 
#accepted<-gsub(",","",str_sub(history[2],start=11)) 
#published<-gsub(",","",str_sub(history[3],start=12)) 
#recieved <- gsub("\u00A0", " ", recieved) #solve the problem of <u+00a0>. thank you enersto Huang (https://stackoverflow.com/users/7549197/enersto-huang)
#accepted <- gsub("\u00A0", " ", accepted)
