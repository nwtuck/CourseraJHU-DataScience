pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  pollutant.data <- data.frame()
  
  ## read all indicated csv files into dataframe pollutant.data 
  for (this.id in rep(id)){
    ## concatenate csv filename to be read to the indicated directory and read csv file
    this.file <- read.csv(paste(directory,"/", formatC(this.id, width=3, flag="0"), ".csv", sep=""))
    
    ## append read data to dataframe pollutant.data
    pollutant.data <- rbind(pollutant.data, this.file)
  }
  
  ## collect indicated pollutant column in a matrix, remove NA entries and return the mean 
  mean(as.matrix(pollutant.data[pollutant]),na.rm=TRUE)
}
