# Scraping the data from Scientific Journals
library(rvest)
library(dplyr)
library(stringr)

#Journal of Animal sciecne
url <- "https://www.animalsciencepublications.org/publications/jas/articles/95/1/9"
html <- read_html(url, encoding="UTF-8")

#keywords
keywords<-html %>% html_nodes(".kwd-group") %>% html_children() %>% html_text()  
keywords<-gsub(";","",keywords) %>% data.frame()

keywords

#history
history<-html %>% html_nodes(".history-list") %>% html_children() %>% html_text() 

recieved<-gsub(",","",str_sub(history[1],start=11))
accepted<-gsub(",","",str_sub(history[2],start=11))
published<-gsub(",","",str_sub(history[3],start=12))

data.frame(recieved=recieved,accepted=accepted,published=published)

#contributor list
contributor<-html %>% html_nodes(".contributor-list") %>% html_children() %>% html_text()
