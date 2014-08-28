## Write a function called rankall that takes two arguments: an
## outcome name (outcome) and a hospital rank- ing (num). The function
## reads the outcome-of-care-measures.csv file and returns a 2-column
## data frame containing the hospital in each state that has the
## ranking specified in num. For example the function call
## rankall("heart attack", "best") would return a data frame
## containing the names of the hospitals that are the best in their
## respective states for 30-day heart attack death rates. The function
## should return a value for every state (some may be NA). The first
## column in the data frame is named hospital, which contains the
## hospital name, and the second column is named state, which contains
## the 2-character abbreviation for the state name. Hospitals that do
## not have data on a particular outcome should be excluded from the
## set of hospitals when deciding the rankings.


rankall <- function(outcome=outcome, num = "best") {

    # read in the file
    fileName="outcome-of-care-measures.csv"
    outcomedata <- read.csv(fileName,colClasses="character")
    outcomes <- list("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    
    states <- unique(outcomedata$State)
    outcomedata$Provider.Number <- as.numeric(outcomedata$Provider.Number)
    for (i in outcomes) {
        outcomedata[[i]]<-as.numeric(outcomedata[[i]])
    }

    ## exception handling: outcomes
    if ( is.null( outcomes[[outcome]] ) ) {
        stop("invalid outcome")
    }


    ranking <- data.frame (hospital=character(), state=character())
    
    for (state in states) {
        ## reorder the data frame:
        stateoutcomes <- outcomedata[outcomedata$State == state,]
        stateoutcomes <- stateoutcomes[order(stateoutcomes[[ outcomes[[outcome]] ]], stateoutcomes$Hospital.Name,na.last = NA),]
        stateranking <- stateoutcomes$Hospital.Name
    
        if (num == 'best') {
            n <- 1
        } else if (num == 'worst') {
            n <- length(stateranking)
        } else {
            n <- num
        }
        ranking <- rbind( ranking, data.frame(hospital=stateranking[n],state=state))
    }
    
    ranking[order(ranking$state),]
}
