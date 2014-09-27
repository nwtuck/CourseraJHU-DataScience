best <- function(state, outcome){
  ## Read outcome data
  outcome.data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  
  # extract unique states list from data
  states <- unique(unlist(outcome.data[,"State"]))
  
  # convert state to upper case and check if state is within list of extracted states, stops function is invalid
  
  state <- toupper(state)
  if (!(state %in% outcome.data[,7]))
    stop("invalid state")
  
  # create list of outcomes with corresponding outcome column in data
  outcomes.code <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
  
  # convert outcome to lower case and find corresponding column from outcomes code
  outcome <- tolower(outcome)
  outcome <- outcomes.code[match(outcome, names(outcomes.code))]
  
  # check if outcome is NA, stops function if invalid
  if (is.na(outcome))
    stop("invalid outcome")
  
  ## Return hospital name in that state with lowest 30-day death rate
  
  # extract hospital name and outcome columns by state 
  outcome.data <- outcome.data[outcome.data$State==state, c(2,outcome)]

  #change all values in outcome column into numeric
  outcome.data[,2] <- as.numeric(outcome.data[,2])
  head(outcome.data[which(outcome.data[,2]==min(outcome.data[,2], na.rm=TRUE)),1],n=1)
}