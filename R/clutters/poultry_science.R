
library(rvest)
library(dplyr)
library(stringr)

#URL list
setwd("D:/GitHub/journal_scraping") #set working directory
list <- readxl::read_excel("journal_URL.xlsx") #set URL list
list <- filter(list, journal == "poultry science") #filtering the journal

#data.frame
poultry_result<-list
poultry_result<-cbind(poultry_result, subject=NA)
poultry_result<-cbind(poultry_result, first_author=NA)

n<-nrow(list)

for(i in 0:(n-1)){
  nb=i+1
  url <- list$URL[nb]
  html <- read_html(url, encoding="UTF-8")

  #Subject
  subject<-html %>% html_nodes(xpath="//div[2]/div[1]/div/div/h1") %>% html_text()  
  subject<-gsub("\r\n"," ",subject)
  
  #first_author
  first_author<-html %>% html_nodes(".al-author-name") %>% html_children() %>% html_text() 
  first_author<-gsub("\r\n"," ",first_author)
  first_author<-gsub(" ","",first_author)
  first_author <- first_author[1]
   
  #write dataframe
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    poultry_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    poultry_result$first_author[nb]<-first_author
  }

}

#write.csv
write.csv(poultry_result,"poultry_result.txt",row.names = FALSE)