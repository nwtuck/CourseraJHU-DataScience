rankall <- function(outcome, num = 'best'){
  ## Read outcome data
  outcome.data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that outcome is valid
  
  # create list of outcomes with corresponding outcome column in data
  outcomes.code <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
  
  # convert outcome to lower case and find corresponding column from outcomes code
  outcome <- tolower(outcome)
  outcome <- outcomes.code[match(outcome, names(outcomes.code))]
  
  # change all values in outcome column into numeric
  outcome.data[,outcome] <- as.numeric(outcome.data[,outcome])
  
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
  
 ## Return a data frame with the hospital names and the (abbreviated) state name

 # extract unique states list from data
 states <- unique(unlist(outcome.data[,"State"]))
 
 # initiate blank hospital ranks data frame 
 hospitals.rank <- data.frame()
 
 #cycle through all states and use rankhospital function to get  
 for(state in states){
   state.hospital <- outcome.data[outcome.data$State==state, c(2,outcome)]
   if(num>nrow(state.hospital)){
     hospital <- NA
   } else {
     hospital <- tail(head(state.hospital[order(state.hospital[,2],state.hospital[,1],decreasing=descend),1],n=num),n=1)
   }
   hospitals.rank <- rbind(hospitals.rank, data.frame(hospital, state=state))
 }
 
 hospitals.rank[order(as.character(hospitals.rank$state)),]
}