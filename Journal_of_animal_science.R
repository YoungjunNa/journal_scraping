##Scraping the data from Scientific Journals
#Author: Youngjun Na
#Email: ruminoreticulum@gmail.com
#Github: https://github.com/YoungjunNa
#Last update: 11/15/2017

library(rvest)
library(dplyr)
library(stringr)

url <- "https://www.animalsciencepublications.org/publications/jas/articles/95/11/4728"

#URL list
setwd("D:/GitHub/journal_scraping") #set working directory
list <- readxl::read_excel("journal_URL.xlsx") #set URL list
list <- filter(list, journal == "journal of animal science") #filtering the journal

#data.frame
JAS_result<-list
JAS_result<-cbind(JAS_result, subject=NA)
JAS_result<-cbind(JAS_result, keywords=NA)
JAS_result<-cbind(JAS_result, first_author=NA)

n<-nrow(list)

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
  
  #first_author
  first_author<-html %>% html_nodes(".contributor-list") %>% html_children() %>% html_text()
  
  first_author<-gsub(" and ","",first_author)
  first_author<-gsub("*","",first_author, fixed=TRUE)
  first_author<-gsub("\\*","",first_author)
  first_author<-gsub("†","",first_author)
  first_author<-gsub("‡","",first_author)
  first_author<-gsub("§","",first_author)
  first_author<-gsub("#","",first_author)
  first_author<-gsub("║","",first_author)
  first_author<-gsub("¶","",first_author)
  first_author<-gsub(",","",first_author)
  first_author<-gsub("1","",first_author)
  first_author<-gsub("2","",first_author)
  first_author<-gsub("3","",first_author)
  first_author<-gsub("4","",first_author)
  first_author<-gsub("\u00A0", "", first_author)
  first_author<-gsub(" ","",first_author)
  first_author<-gsub("\n\t"," ",first_author)
  
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    JAS_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(keywords),integer(0)) != TRUE){
    JAS_result$keywords[nb] <- keywords
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    JAS_result$first_author[nb]<-first_author[1]
  }

}

#write.csv
write.csv(JAS_result,"JAS_result.txt",row.names = FALSE)

#corresponding_author
#corresponding<-html %>% html_node(".fn-corresp") %>% html_children() %>% .[[2]] %>% html_text() 

##history
#history<-data.frame(recieved=recieved,accepted=accepted,published=published, corresponding=NA)
#history<-html %>% html_nodes(".history-list") %>% html_children() %>% html_text() 
#recieved<-gsub(",","",str_sub(history[1],start=11)) 
#accepted<-gsub(",","",str_sub(history[2],start=11)) 
#published<-gsub(",","",str_sub(history[3],start=12)) 
#recieved <- gsub("\u00A0", " ", recieved) #solve the problem of <u+00a0>. thank you enersto Huang (https://stackoverflow.com/users/7549197/enersto-huang)
#accepted <- gsub("\u00A0", " ", accepted)
