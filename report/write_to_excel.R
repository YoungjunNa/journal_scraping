pacman::p_load("xlsx")

results <- read.csv("journal_result_2018_1.txt",stringsAsFactors = FALSE)
write.xlsx(results, file="journal_result_2018_1.xlsx", sheetName="Sheet1")
