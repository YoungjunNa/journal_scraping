##Scraping the data from Scientific Journals
#Author: Youngjun Na
#Email: ruminoreticulum@gmail.com
#Github: https://github.com/YoungjunNa
#Date: 11/2/2017

library(rvest)
library(dplyr)
library(stringr)
library(lubridate)

#data.frame
keywords<-data.frame(vol=vol, issue=issue, page=page,keywords=keywords)
history<-data.frame(recieved=recieved,accepted=accepted,published=published, corresponding=NA)

#Journal of Animal sciecne
vol<-95
issue<-10
page<-4239

url <- paste0("https://www.animalsciencepublications.org/publications/jas/articles/",vol,"/",issue,"/",page)
html <- read_html(url, encoding="UTF-8")

#keywords
keywords<-html %>% html_nodes(".kwd-group") %>% html_children() %>% html_text()  
keywords<-gsub(";","",keywords)
keywords

#history
history<-html %>% html_nodes(".history-list") %>% html_children() %>% html_text() 

recieved<-gsub(",","",str_sub(history[1],start=11)) 
accepted<-gsub(",","",str_sub(history[2],start=11)) 
published<-gsub(",","",str_sub(history[3],start=12)) 

recieved <- gsub("\u00A0", " ", recieved) #solve the problem of <u+00a0>. thank you enersto Huang (https://stackoverflow.com/users/7549197/enersto-huang)
accepted <- gsub("\u00A0", " ", accepted)

#numMonth <- function(x) {
#  months <- list(Jan=1,Feb=2,Mar=3,Apr=4,May=5,Jun=6,July=7,Aug=8,Sep=9,Oct=10,Nov=11,Dec=12)
#  x <- tolower(x)
#  sapply(x,function(x) months[[x]])
#}

history

#corresponding_author
corresponding<-html %>% html_node(".fn-corresp") %>% html_children() %>% .[[2]] %>% html_text() 

history[,4]<-corresponding

history

#write.csv

write.csv(history,"history.txt",row.names = FALSE)
