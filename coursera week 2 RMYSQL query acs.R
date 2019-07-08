library(RMySQL)
library(DBI)
library(sqldf)

setwd("E:/R")

acs <- read.csv("getdata_data_ss06pid.csv")

# connecting to MySQL server
con <- dbConnect(MySQL(),
                 user = 'root',
                 password = 'root',
                 host = 'localhost',
                 dbname = 'test')

# sqldf("select pwgtp1 from acs where AGEP < 50")
pwgtp1 <- dbSendQuery(con,
                      "SELECT pwgtp1 FROM acs WHERE AGEP < 50")
dbBind(pwgtp1, list("result"))
result <- dbFetch(pwgtp1)

# sqldf("select distinct AGEP from acs")
query <- dbSendQuery(con,
                     "SELECT DISTINCT AGEP FROM acs")
result <- dbFetch(query)
