# import data
outcome <- read.csv("outcome-of-care-measures.csv", na.strings = "NA",
                    stringsAsFactors = F)
str(outcome)
glimpse(outcome)

# check na
sum(is.na(outcome))

# selecting variables
outcome <- outcome %>%
  select(Hospital.Name, State,
         Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
         Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
         Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>%
  rename(Hospital = Hospital.Name,
         HeartAttack = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
         HeartFailure= Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
         Pneumonia = Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>%
  as.data.frame()

# hospital ranking function
hospitalranking <- function(state, outcometype, rank) {
      # import data
      outcome <- read.csv("outcome-of-care-measures.csv", na.strings = "NA",
                          stringsAsFactors = F)
      
      # selecting variables
      outcome <- outcome %>%
        select(Hospital.Name, State,
               Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
               Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
               Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>%
        rename(Hospital = Hospital.Name,
               HeartAttack = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
               HeartFailure= Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
               Pneumonia = Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>%
        as.data.frame()
      
      # sorting, removing na, and split the outcome data
      outcome <- outcome %>%
          select(Hospital, State, contains(outcometype)) %>%
          as.numeric(outcome[,3]) >%>
          na.omit() %>%
          filter(State == state) %>%
          arrange(outcome[,3], Hospital)
      
      #ranking the hospital
      if (rank == "worst") {
        print(head(outcome["Hospital"], 1))
      } else if (rank == "best") {
        print(tail(outcome["Hospital"], 1))
      }
}


outcomeval <- c("HeartAttack" = "heart attack", 
                "HeartFailure" = "heart failure",
                "Pneumonia" = "pneumonia")
sakit <- "pneumonia"
test <- select(outcome, Hospital, State, contains(sakit))
test[,3] <- as.numeric(test[,3])
test <- na.omit(test)
kota <- "NY"
rank <- "best"
test <- test %>%
  # group_by(State) %>%
  filter(State == kota) %>%
  arrange(Pneumonia, Hospital)
if (rank == "worst") {
      print(head(test["Hospital"],1))
} else if (rank == "best") {
  print(tail(test["Hospital"],1))
}
