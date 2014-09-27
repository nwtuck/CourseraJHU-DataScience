corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  ## make use of complete() from previous part to extract number of complete cases in all files
  complete <- complete(directory)
  
  ## remove files with complete casess below threshold from data frame 
  complete <- complete[complete$nobs>threshold,]
  
  ## initiate correlation vector 
  correlation <- numeric()
  
  ## read all files that meet threshold, get and save correlation between nitrate and sulfate in correlation vector
  for (this.id in rep(complete$id)){
    ## concatenate csv filename to be read to the indicated directory and read csv file
    this.file <- read.csv(paste(directory,"/", formatC(this.id, width=3, flag="0"), ".csv", sep=""))
    
    #get correlation of complete cases in current file and append to correlation vector
    correlation <- c(correlation, cor(this.file$nitrate, this.file$sulfate, use='complete.obs'))
  }
  correlation
}