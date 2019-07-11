library(tidyverse)

# soal 1
acs <- read.csv("./data/getdata_data_ss06hid.csv")
head(acs)

agriculture <- acs %>%
              select(ACR, AGS)

agricultureLogical <- agriculture[which(agriculture$ACR == 3 & 
                                          agriculture$AGS == 6),]
agricultureLogical

#soal 2
library(jpeg)

pict <- readJPEG("./data/getdata_jeff.jpg", native = TRUE)
quantile(pict, p = 0.3)
quantile(pict, p = 0.8)