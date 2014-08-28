
## Write a function called rankhospital that takes three arguments: the
## 2-character abbreviated name of a state (state), an outcome (outcome),
## and the ranking of a hospital in that state for that outcome
## (num). The function reads the outcome-of-care-measures.csv file and
## returns a character vector with the name of the hospital that has the
## ranking specified by the num argument. For example, the call
## rankhospital("MD", "heart failure", 5) would return a character vector
## containing the name of the hospital with the 5th lowest 30-day death
## rate for heart failure. The num argument can take values “best”,
## “worst”, or an integer indicating the ranking (smaller numbers are
## better). If the number given by num is larger than the number of
## hospitals in that state, then the function should return NA. Hospitals
## that do not have data on a particular outcome should be excluded from
## the set of hospitals when deciding the rankings.  Handling ties. It
## may occur that multiple hospitals have the same 30-day mortality rate
## for a given cause of death. In those cases ties should be broken by
## using the hospital name. 

rankhospital <- function(state=state, outcome=outcome, num = "best") {

    # read in the file
    fileName="outcome-of-care-measures.csv"
    outcomedata <- read.csv(fileName,colClasses="character")
    outcomes <- list("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    
    states <- unique(outcomedata$State)
    outcomedata$Provider.Number <- as.numeric(outcomedata$Provider.Number)
    for (i in outcomes) {
        outcomedata[[i]]<-as.numeric(outcomedata[[i]])
    }
    
    ## exception handling: states
    if ( is.na(match(state,states)) ) {
        stop("invalid state")
    }

    ## exception handling: outcomes
    if ( is.null( outcomes[[outcome]] ) ) {
        stop("invalid outcome")
    }


    ## reorder the data frame:
    outcomedata <- outcomedata[outcomedata$State == state,]
    outcomedata <- outcomedata[order(outcomedata[[ outcomes[[outcome]] ]], outcomedata$Hospital.Name,na.last = NA),]
    ranking <- outcomedata$Hospital.Name
    
    if (num == 'best') {
        num <- 1
    } else if (num == 'worst') {
        num <- length(ranking)
    }

    ranking[num]
    
}
