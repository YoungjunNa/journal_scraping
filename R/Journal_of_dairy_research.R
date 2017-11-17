
library(rvest)
library(dplyr)
library(stringr)

#URL list
setwd("D:/GitHub/journal_scraping") #set working directory
list <- readxl::read_excel("journal_URL.xlsx") #set URL list
list <- filter(list, journal == "journal of dairy research") #filtering the journal

#data.frame
JDR_result<-list
JDR_result<-cbind(JDR_result, subject=NA)
JDR_result<-cbind(JDR_result, first_author=NA)

n<-nrow(list)

for(i in 0:(n-1)){
  nb=i+1
  url <- list$URL[nb]
  html <- read_html(url, encoding="UTF-8")
  
  #Subject
  subject<-html %>% html_nodes(".article-title") %>% html_text()
  subject <- subject[1]
  
  #first_author
  first_author <- html %>% html_node(".author") %>% html_children() %>% html_text() 
  first_author <- first_author[1]
  first_author <- gsub(" ","",first_author)
  
  #write dataframe
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    JDR_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    JDR_result$first_author[nb]<-first_author
  }
  
}


#write.csv
write.csv(JDR_result,"JDR_result.txt",row.names = FALSE)