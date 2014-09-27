complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  ## initiate and pre-allocate space in data frame with number of files to be read
  ## pre-allocation method is fastest, followed by list, then rbind
  n <- length(id)
  complete.data <- data.frame(id = numeric(n), nobs = numeric(n))
    
  ## counter tracks which row to insert data to cater for id not starting at 1
  counter <- 1

  ## read all indicated csv files into dataframe complete.data 
  for (this.id in rep(id)){
    ## concatenate csv filename to be read to the indicated directory and read csv file
    this.file <- read.csv(paste(directory,"/", formatC(this.id, width=3, flag="0"), ".csv", sep=""))
    
    ## count number of complete cases in current file
    complete <- nrow(this.file[complete.cases(this.file),])
    
    ## add read data to dataframe complete.data and increase counter
    complete.data$id[counter] <- this.id
    complete.data$nobs[counter] <- complete
    counter <- counter + 1
  }
  
  complete.data
}