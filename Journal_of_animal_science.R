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

#Journal of Animal sciecne
url <- list$URL[1]
html <- read_html(url, encoding="UTF-8")

#Subject
subject<-html %>% html_nodes(xpath="//div/h1/text()") %>% html_text()  
JAS_result$subject[1] <- subject

#keywords
keywords<-html %>% html_nodes(".kwd-group") %>% html_text()  
keywords<-gsub(";","",keywords)
keywords<-gsub("\n\t","",keywords)
JAS_result$keywords[1] <- keywords

#corresponding_author
corresponding<-html %>% html_node(".fn-corresp") %>% html_children() %>% .[[2]] %>% html_text() 
JAS_result$corresponding[1]<-corresponding

#write.csv
write.csv(history,"history.txt",row.names = FALSE)

##history
#history<-data.frame(recieved=recieved,accepted=accepted,published=published, corresponding=NA)
#history<-html %>% html_nodes(".history-list") %>% html_children() %>% html_text() 
#recieved<-gsub(",","",str_sub(history[1],start=11)) 
#accepted<-gsub(",","",str_sub(history[2],start=11)) 
#published<-gsub(",","",str_sub(history[3],start=12)) 
#recieved <- gsub("\u00A0", " ", recieved) #solve the problem of <u+00a0>. thank you enersto Huang (https://stackoverflow.com/users/7549197/enersto-huang)
#accepted <- gsub("\u00A0", " ", accepted)
