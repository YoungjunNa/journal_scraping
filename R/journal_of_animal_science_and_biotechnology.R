
library(rvest)
library(dplyr)
library(stringr)

#URL list
setwd("D:/GitHub/journal_scraping") #set working directory
list <- readxl::read_excel("journal_URL.xlsx") #set URL list
list <- filter(list, journal == "journal of animal science and biotechnology") #filtering the journal

#data.frame
JASB_result<-list
JASB_result<-cbind(JASB_result, subject=NA)
JASB_result<-cbind(JASB_result, first_author=NA)

n<-nrow(list)

for(i in 0:(n-1)){
  nb=i+1
  url <- list$URL[nb]
  html <- read_html(url, encoding="UTF-8")
  
    #Subject
  subject<-html %>% html_nodes(".ArticleTitle") %>% html_text()  
  
  #first_author
  first_author<-html %>% html_node(".test-contributor-names") %>% html_children() %>% html_text() 
  
  first_author <- first_author[1]
  first_author<-gsub("\u00A0", " ", first_author)
  
  #write dataframe
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    JASB_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    JASB_result$first_author[nb]<-first_author
  }
  
}

#write.csv
write.csv(JASB_result,"JASB_result.txt",row.names = FALSE)

