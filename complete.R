complete <- function(directory=directory, id = 1:332) {

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

    readdata <- function(directory=directory, id) {
        
        ## set up an empty data frame to hold the data
        pollutantData <- data.frame ( date=as.Date(character()),
                                     sulfate=double(), nitrate=double(),
                                     ID=integer() )

        ## not going to do any exception handling here; assume
        ## directory exists, files are readable and named NN.csv
        
        for (fileNr in id) {
            fileName <- paste(directory, '/',
                              formatC(fileNr,width = 3, flag = 0), '.', 'csv',
                              sep = '')
            ## print (fileName)
            
            pollutantData <- rbind( pollutantData, read.csv(fileName))
        }

        pollutantData
    }

    pollutantData <- readdata(directory=directory, id=id)

    completeObs <- data.frame ( id=integer(), nobs=integer() )
   
    ## need SELECT WHERE id=id AND sulfate != NA AND nitrate != NA
    completeData <- pollutantData[ (! (  is.na(pollutantData$sulfate)
                                       | is.na(pollutantData$nitrate)
                                       )), ]

   for (i in id) {
        completeObs <- rbind( completeObs,
              c(i,
                (nrow(completeData[completeData$ID == i,])))
              )
    }

    names(completeObs) <- c('id','nobs')
    completeObs                         
}
