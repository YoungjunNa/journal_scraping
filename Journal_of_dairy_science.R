##Scraping the data from Scientific Journals
#Author: Youngjun Na
#Email: ruminoreticulum@gmail.com
#Github: https://github.com/YoungjunNa
#Last update: 11/15/2017

library(rvest)
library(dplyr)
library(stringr)

#URL list
setwd("D:/GitHub/journal_scraping") #set working directory
list <- readxl::read_excel("journal_URL.xlsx") #set URL list
list <- filter(list, journal == "journal of dairy science") #filtering the journal

#data.frame
JDS_result<-list
JDS_result<-cbind(JDS_result, subject=NA)
JDS_result<-cbind(JDS_result, keywords=NA)
JDS_result<-cbind(JDS_result, authorship=NA)

n<-nrow(list)


for(i in 0:(n-1)){
  nb=i+1
  url <- list$URL[nb]
  html <- read_html(url, encoding="UTF-8")
  
  #Subject
  subject<-html %>% html_nodes(".title-text") %>% html_text()  
  
  #keywords
  keywords<-html %>% html_nodes(".Keywords") %>% html_children() %>% html_text()  
  keywords<-gsub("Key words","",keywords)
  
  #authorship
  authorship<-html %>% html_node(".author-group") %>% html_children() %>% html_text() 
  
  authorship <- authorship[-1]
  
  authorship<-gsub(" and ","",authorship)
  authorship<-gsub("*","",authorship, fixed=TRUE)
  authorship<-gsub("\\*","",authorship)
  authorship<-gsub("†","",authorship)
  authorship<-gsub("‡","",authorship)
  authorship<-gsub("§","",authorship)
  authorship<-gsub("#","",authorship)
  authorship<-gsub("║","",authorship)
  authorship<-gsub("¶","",authorship)
  authorship<-gsub(",","",authorship)
  authorship<-gsub("1","",authorship)
  authorship<-gsub("2","",authorship)
  authorship<-gsub("3","",authorship)
  authorship<-gsub("4","",authorship)
  authorship<-gsub("\u00A0", "", authorship)
  authorship<-gsub(" ","",authorship)
  authorship<-gsub("\n\t"," ",authorship)
  
  
  #write dataframe
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    JDS_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(keywords),integer(0)) != TRUE){
    JDS_result$keywords[nb] <- keywords
  }
  
  if(all.equal(nchar(authorship),integer(0)) != TRUE){
    JDS_result$authorship[nb]<-authorship
  }
  
}
  

#write.csv
write.csv(JDS_result,"JDS_result.txt",row.names = FALSE)
