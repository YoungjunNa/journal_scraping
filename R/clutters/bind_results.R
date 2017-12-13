
library(dplyr)

journal_result <- bind_rows(JAS_result,JDS_result,AJAS_result,animal_result,poultry_result,JDR_result,JASB_result,revista_brasileira_result,ANIFEED_result)

write.csv(journal_result,"journal_result.txt",row.names=FALSE)
