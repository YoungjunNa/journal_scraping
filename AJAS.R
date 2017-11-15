##Scraping the data from Scientific Journals
#Author: Youngjun Na
#Email: ruminoreticulum@gmail.com
#Github: https://github.com/YoungjunNa
#Date: 11/2/2017

library(rvest)
library(dplyr)
library(stringr)

url <- "https://www.ajas.info/journal/view.php?number=23783"
html <- read_html(url, encoding="UTF-8")

#Subject
subject<-html %>% html_nodes(".PubTitle") %>% html_text()  

#1st author
authorship<-html %>% html_node(xpath="//div[3]/div/div[7]") %>% html_children() %>% html_text() 
authorship <- authorship[1]
authorship <- gsub(" ","",authorship)
