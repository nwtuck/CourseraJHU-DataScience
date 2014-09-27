rankhospital <- function(state, outcome, num = 'best'){
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
  
  # check if num is valid, sets parameters
  descend <- FALSE
  
  if(num=="worst"){
    descend <- TRUE
    num <- 1
  } else if(num=="best"){
    num <- 1
  } else if(!(is.numeric(num))){
    stop("invalid num")
  }
  
  ## Return hospital name in that state with given rank
  
  # extract hospital name and outcome columns by state 
  outcome.data <- outcome.data[outcome.data$State==state, c(2,outcome)]
  
  # returns NA if num is more than number of hospital in state
  if(num>nrow(outcome.data))
    return(NA)
  
  #change all values in outcome column into numeric
  outcome.data[,2] <- as.numeric(outcome.data[,2])
  
  # order hospital by outcome and name, return hospital name of given rank
  
  tail(head(outcome.data[order(outcome.data[,2],outcome.data[,1],decreasing=descend),1],n=num),n=1)
}