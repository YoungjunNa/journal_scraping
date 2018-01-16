#new JAS scraping form (Oxford Univ. press)

#library
pacman::p_load("rvest","dplyr","stringr")

#URL list
setwd("E:/GitHub/journal_scraping") #set working directory
list <- readxl::read_excel("journal_URL.xlsx") #set URL list

#filtering the journal
list <- filter(list, journal == "journal of animal science")
list <- filter(list, year == 2018)
list <- filter(list, month == 1)

#data.frame
JAS_result<-list
JAS_result<-cbind(JAS_result, subject=NA)
JAS_result<-cbind(JAS_result, first_author=NA)

n<-nrow(list)

for(i in 0:(n-1)){
  nb=i+1
  url <- list$URL[nb]
  html <- read_html(url, encoding="UTF-8")
  
  #Subject
  subject<-html %>% html_nodes(xpath="///div[2]/div[1]/div/div/h1") %>% html_text()  
  
  #first_author
  first_author<-html %>% html_nodes(".wi-authors") %>% html_children() %>% html_text()
  
  first_author <- str_sub(first_author[1], 1, 122) #아웅 이렇게까지 해야하나...
  first_author<-gsub("\r\n"," ",first_author)
  first_author<-gsub(" ","",first_author)
  
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
  
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    JAS_result$first_author[nb]<-first_author[1]
  }
  
}

#write.csv
write.csv(JAS_result,"JAS_result.txt",row.names = FALSE)
