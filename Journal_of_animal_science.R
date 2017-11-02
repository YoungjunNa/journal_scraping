##Scraping the data from Scientific Journals
#Author: Youngjun Na
#Email: ruminoreticulum@gmail.com
#Github: https://github.com/YoungjunNa
#Date: 11/2/2017

library(rvest)
library(dplyr)
library(stringr)
library(lubridate)

#Journal of Animal sciecne
vol<-95
issue<-2
page<-789

url <- paste0("https://www.animalsciencepublications.org/publications/jas/articles/",vol,"/",issue,"/",page)
html <- read_html(url, encoding="UTF-8")

#keywords
keywords<-html %>% html_nodes(".kwd-group") %>% html_children() %>% html_text()  
keywords<-gsub(";","",keywords)
keywords<-data.frame(vol=vol, issue=issue, page=page,keywords=keywords)

keywords

#history
history<-html %>% html_nodes(".history-list") %>% html_children() %>% html_text() 

recieved<-gsub(",","",str_sub(history[1],start=11)) %>% as.character()
accepted<-gsub(",","",str_sub(history[2],start=11)) %>% as.character()
published<-gsub(",","",str_sub(history[3],start=12)) %>% as.character()

history<-data.frame(recieved=recieved,accepted=accepted,published=published, corresponding=NA)

history

#corresponding_author
corresponding<-html %>% html_node(".fn-corresp") %>% html_children() %>% .[[2]] %>% html_text() 

history[,4]<-corresponding

history
