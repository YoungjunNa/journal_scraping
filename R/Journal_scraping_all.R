# journal_scraping_all
# libary ####
pacman::p_load("rvest","dplyr","stringr")

# URL list ####
setwd("E:/GitHub/journal_scraping") #set working directory for PC
#setwd("/Users/Youngjun/GitHub/journal_scraping") #set wd for Mac
list <- readxl::read_excel("journal_URL.xlsx") #set URL list
list <- filter(list, year==2018 & month==1)

# JAS=====================================================================================
list_JAS <- filter(list, journal == "journal of animal science") #filtering the journal

#data.frame
JAS_result<-list_JAS
JAS_result<-cbind(JAS_result, subject=NA)
JAS_result<-cbind(JAS_result, first_author=NA)

n<-nrow(list_JAS)

for(i in 0:(n-1)){
  nb=i+1
  url <- list_JAS$URL[nb]
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


# JDS==============================================================================
list_JDS <- filter(list, journal == "journal of dairy science") #filtering the journal

#data.frame
JDS_result<-list_JDS
JDS_result<-cbind(JDS_result, subject=NA)
JDS_result<-cbind(JDS_result, first_author=NA)

n<-nrow(list_JDS)

for(i in 0:(n-1)){
  nb=i+1
  url <- list_JDS$URL[nb]
  html <- read_html(url, encoding="UTF-8")
  
  #Subject
  subject<-html %>% html_nodes(".title-text") %>% html_text()  
  
  #first_author
  first_author<-html %>% html_node(".author-group") %>% html_children() %>% html_text() 
  
  first_author <- first_author[-1]
  
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
  
  #write dataframe
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    JDS_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    JDS_result$first_author[nb]<-first_author
  }
  
}

# ANIFEED==============================================================================
list_ANIFEED <- filter(list, journal == "animal feed science and technology") #filtering the journal

#data.frame
ANIFEED_result<-list_ANIFEED
ANIFEED_result<-cbind(ANIFEED_result, subject=NA)
ANIFEED_result<-cbind(ANIFEED_result, first_author=NA)

n<-nrow(list_ANIFEED)

for(i in 0:(n-1)){
  nb=i+1
  url <- list_ANIFEED$URL[nb]
  html <- read_html(url, encoding="UTF-8")
  
  #Subject
  subject<-html %>% html_nodes(".title-text") %>% html_text()  
  
  #first_author
  first_author<-html %>% html_node(".author-group") %>% html_children() %>% html_text() 
  
  first_author <- first_author[2]
  
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
  
  #write dataframe
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    ANIFEED_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    ANIFEED_result$first_author[nb]<-first_author
  }
  
}

# animal=============================================================================
list_animal <- filter(list, journal == "animal") #filtering the journal

#data.frame
animal_result<-list_animal
animal_result<-cbind(animal_result, subject=NA)
animal_result<-cbind(animal_result, first_author=NA)

n<-nrow(list_animal)

for(i in 0:(n-1)){
  nb=i+1
  url <- list_animal$URL[nb]
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
    animal_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    animal_result$first_author[nb]<-first_author
  }
  
}

# livestock_sci========================================================================
list_LS <- filter(list, journal == "livestock science") #filtering the journal

#data.frame
livestock_science_result<-list_LS
livestock_science_result<-cbind(livestock_science_result, subject=NA)
livestock_science_result<-cbind(livestock_science_result, first_author=NA)

n<-nrow(list_LS)

for(i in 0:(n-1)){
  nb=i+1
  url <- list_LS$URL[nb]
  html <- read_html(url, encoding="UTF-8")
  
  #Subject
  subject<-html %>% html_nodes(".title-text") %>% html_text()  
  
  #first_author
  first_author<-html %>% html_node(".author-group") %>% html_children() %>% html_text() 
  
  first_author <- first_author[2]
  
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
  first_author<-gsub("\u00A0", " ", first_author)
  first_author<-gsub(" ","",first_author)
  first_author<-gsub("\n\t"," ",first_author)
  
  #write dataframe
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    livestock_science_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    livestock_science_result$first_author[nb]<-first_author
  }
  
}


# PS ####
list_PS <- filter(list, journal == "poultry science") #filtering the journal

#data.frame
poultry_result<-list_PS
poultry_result<-cbind(poultry_result, subject=NA)
poultry_result<-cbind(poultry_result, first_author=NA)

n<-nrow(list_PS)

for(i in 0:(n-1)){
  nb=i+1
  url <- list_PS$URL[nb]
  html <- read_html(url, encoding="UTF-8")
  
  #Subject
  subject<-html %>% html_nodes(xpath="//div[2]/div[1]/div/div/h1") %>% html_text()  
  subject<-gsub("\r\n"," ",subject)
  
  #first_author
  first_author<-html %>% html_nodes(".al-author-name") %>% html_children() %>% html_text() 
  first_author <- str_sub(first_author[1], 1, 55)
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


#AJAS================================================================================
list_AJAS <- filter(list, journal == "AJAS") #filtering the journal

#data.frame
AJAS_result<-list_AJAS
AJAS_result<-cbind(AJAS_result, subject=NA)
AJAS_result<-cbind(AJAS_result, first_author=NA)

n<-nrow(list_AJAS)

for(i in 0:(n-1)){
  nb=i+1
  url <- list_AJAS$URL[nb]
  html <- read_html(url, encoding=guess_encoding(url)[1,1])
  
  #Subject
  subject<-html %>% html_nodes(".PubTitle") %>% html_text()  
  
  #1st author
  first_author<-html %>% html_node(xpath="//div[3]/div/div[7]") %>% html_children() %>% html_text() 
  first_author <- first_author[1]
  first_author <- gsub(" ","",first_author)
  
  if(all.equal(nchar(subject),integer(0)) != TRUE){
    AJAS_result$subject[nb] <- subject
  }
  
  if(all.equal(nchar(first_author),integer(0)) != TRUE){
    AJAS_result$first_author[nb]<-first_author[1]
  }
  
}



#JASB==============================================================================
list_JASB <- filter(list, journal == "journal of animal science and biotechnology") #filtering the journal

#data.frame
JASB_result<-list_JASB
JASB_result<-cbind(JASB_result, subject=NA)
JASB_result<-cbind(JASB_result, first_author=NA)

n<-nrow(list_JASB)

for(i in 0:(n-1)){
  nb=i+1
  url <- list_JASB$URL[nb]
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
#RBDZ=========================================================================================
list_RBDZ <- filter(list, journal == "revista brasileira de zootecnia") #filtering the journal

#data.frame
revista_brasileira_result<-list_RBDZ
revista_brasileira_result<-cbind(revista_brasileira_result, subject=NA)
revista_brasileira_result<-cbind(revista_brasileira_result, first_author=NA)

n<-nrow(list_RBDZ)

for(i in 0:(n-1)){
  nb=i+1
  url <- list_RBDZ$URL[nb]
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


#bind======================================================================================================
journal_result <- bind_rows(JAS_result,JDS_result,AJAS_result,livestock_science_result,animal_result,poultry_result,JASB_result,revista_brasileira_result,ANIFEED_result)
nrow(list)==nrow(journal_result)

write.csv(journal_result,"journal_result_2018_1.txt",row.names=FALSE)

pacman::p_load("xlsx")
write.xlsx(journal_result, file="journal_result_2018_1.xlsx", sheetName="Sheet1")
