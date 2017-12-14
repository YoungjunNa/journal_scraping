#.Renviron
GL_AUTH="C:/Users/Youngjun/Google Drive/Google_cloud/translateR-079f74265489.json"

library(googleLanguageR)
gl_auth("C:/Users/Youngjun/Google Drive/Google_cloud/translateR-079f74265489.json")

result <- read.csv("journal_result_2017_12.txt")
result$subject <- as.character(result$subject)
result$subject <- as.vector(result$subject)


result <- cbind(result, google_translate=NA)

n <- nrow(result)

google <- function(x){
  gl_translate(x, target = "ko")[1]
}

for(i in 0:(n-1)){
  i+1
  translated <- nchar(result$subject[i])
  result$google_translate[i] <- translated[1]
}


for(i in 0:(n-1)){
  i+1
  translated <- gl_translate(result$subject[i], target = "ko")
  result$google_translate[i] <- translated[1]
}


gl_translate(result$subject[11], target = "ko")[1]

