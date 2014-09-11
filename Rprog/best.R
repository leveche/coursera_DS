

## Write a function called best that take two arguments: the
## 2-character abbreviated name of a state and an outcome name.

## The function reads the outcome-of-care-measures.csv file and
## returns a character vector with the name of the hospital that has
## the best (i.e. lowest) 30-day mortality for the specified outcome
## in that state. The hospital name is the name provided in the
## Hospital.Name variable.

## The outcomes can be one of “heart attack”, “heart failure”, or
## “pneumonia”. Hospitals that do not have data on a particular
## outcome should be excluded from the set of hospitals when deciding
## the rankings.

## Handling ties: If there is a tie for the best hospital for a given
## outcome, then the hospital names should be sorted in alphabetical
## order and the first hospital in that set should be chosen (i.e. if
## hospitals “b”, “c”, and “f” are tied for best, then hospital “b”
## should be returned).

## If an invalid state value is passed to best, the function should
## throw an error via the stop function with the exact message
## “invalid state”. If an invalid outcome value is passed to best, the
## function should throw an error via the stop function with the exact
## message “invalid outcome”.

best <- function(state=state, outcome=outcome) {

    # read in the file
    fileName="outcome-of-care-measures.csv"
    outcomedata <- read.csv(fileName,colClasses="character")
    outcomes <- list("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    
    states <- unique(outcomedata$State)
    outcomedata$Provider.Number <- as.numeric(outcomedata$Provider.Number)
    for (i in outcomes) {
        outcomedata[[i]]<-as.numeric(outcomedata[[i]])
    }
    
    # exception handling: states
    if ( is.na(match(state,states)) ) {
        stop("invalid state")
    }

    # exception handling: outcomes
    if ( is.null( outcomes[[outcome]] ) ) {
        stop("invalid outcome")
    }

    ## get the vector of outcomes for given condition in given state, find min
    ## then find hospitals in that state satisfying that min

    bestOutcome <- min(outcomedata[outcomedata$State==state,][[
outcomes[[outcome]] ]], na.rm=TRUE)

    bestCandidates <- sort( unique( outcomedata[ (outcomedata$State==state &
outcomedata[[outcomes[[outcome]]]] == bestOutcome) ,]$Hospital.Name) )

    bestCandidates 

}
