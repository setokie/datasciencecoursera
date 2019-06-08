pollutantmean <- function(directory, pollutant, id = 1:332){
  #listing all files in selected directory
  files <- list.files(directory, full.names = T)
  
  #read csv files
  df <- data.frame()
  for (i in id){
    df <- rbind(df, read.csv(files[i]))
  }
  
  #calculate mean for the pollutant
  mean(df[[pollutant]], na.rm = T)
}

complete <- function(directory, id = 1:332){
  #listing all files in selected directory
  files <- list.files(directory, full.names = T)
  
  #read csv files and count the complete cases
  dfc <- data.frame("id" = id, "nobs" = "")
  nobs <- NULL
  j <- 1
  for (i in id) {
    current_file <- read.csv(files[i])
    nobs[j] <- sum(complete.cases(current_file))
    j <- j + 1
  }
  dfc["nobs"] <- nobs
  print(dfc)
}

corr <- function(directory, threshold = 0) {
  #listing all files in selected directory
  files <- list.files(directory, full.names = T)
  
  cor_result <- numeric()
  
  for (i in seq_along(files)) {
    current_file <- read.csv(files[i])
    sum_nobs <- sum(complete.cases(current_file))
    if (sum_nobs > threshold) {
      corv = cor(current_file$sulfate, 
                 current_file$nitrate, 
                 use = "complete.obs")
      
      cor_result <- append(cor_result, corv)
    }
  }
  cor_result
}