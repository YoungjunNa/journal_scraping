
library(rvest)
library(dplyr)
library(stringr)

#URL list
setwd("D:/GitHub/journal_scraping") #set working directory
list <- readxl::read_excel("journal_URL.xlsx") #set URL list
list <- filter(list, journal == "revista brasileira de zootecnia") #filtering the journal

#data.frame
revista_brasileira_result<-list
revista_brasileira_result<-cbind(revista_brasileira_result, subject=NA)
revista_brasileira_result<-cbind(revista_brasileira_result, first_author=NA)

n<-nrow(list)

for(i in 0:(n-1)){
  nb=i+1
  url <- list$URL[nb]
  html <- read_html(url, encoding="UTF-8")
  
  #Subject
  subject<-html %>% html_nodes(".title") %>% html_text()  
  
  #first_author
  first_author<-html %>% html_node(".autores") %>% html_children() %>% html_text() 
  first_author <- first_author[1]
  
  first_author<-gsub("*","",first_author, fixed=TRUE)
  first_author<-gsub(" and ","",first_author)
  first_author<-gsub("1","",first_author)
  first_author<-gsub("2","",first_author)
  first_author<-gsub("3","",first_author)
  first_author<-gsub("4","",first_author)
  first_author<-gsub("\u00A0", "", first_author)
  
  first_author<-gsub("\n","",first_author)
  first_author<-gsub("\t","",first_author)
  
    #write dataframe
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    revista_brasileira_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    revista_brasileira_result$first_author[nb]<-first_author
  }
}

#write.csv
write.csv(revista_brasileira_result,"revista_brasileira_result.txt",row.names = FALSE)
