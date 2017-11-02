##Scraping the data from Scientific Journals
#Author: Youngjun Na
#Email: ruminoreticulum@gmail.com
#Github: https://github.com/YoungjunNa
#Date: 11/2/2017

library(rvest)
library(dplyr)
library(stringr)
library(lubridate)

#AJAS
no<-23723

url <- paste0("https://www.ajas.info/journal/view.php?number=",no)
html <- read_html(url, encoding="UTF-8")

#keywords
keywords<-html %>% html_nodes(".metadata-entry") %>% html_children() %>% html_text()  
keywords<-data.frame(keywords=keywords[11:15])
keywords

#history
history<-html %>% html_nodes(".metadata-group") %>% html_children() %>% html_text() 

recieved<-gsub("Received ","",history[19]) %>% str_trim()
revised<-gsub("Revised ","",history[20]) %>% str_trim()
accepted<-gsub("Accepted ","",history[21]) %>% str_trim()

history<-data.frame(recieved=recieved,revised=revised, accepted=accepted, corresponding=NA, stringsAsFactors = FALSE, url=url)
history

#corresponding_author
corresponding<-html %>% html_node(".corresp") %>% html_children() %>% .[[3]] %>% html_text() 

history[1,4]<-corresponding
history
