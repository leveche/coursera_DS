
corr <- function(directory=directory, threshold = 0) {

    ## Write a function that takes a directory of data files and a
    ## threshold for complete cases and calculates the correlation
    ## between sulfate and nitrate for monitor locations where the
    ## number of completely observed cases (on all variables) is
    ## greater than the threshold. The function should return a vector
    ## of correlations for the monitors that meet the threshold
    ## requirement. If no monitors meet the threshold requirement,
    ## then the function should return a numeric vector of length 0. A
    ## prototype of this function follows

    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0

    readdata <- function(directory=directory) {
        
        ## set up an empty data frame to hold the data
        pollutantData <- data.frame ( date=as.Date(character()),
                                     sulfate=double(), nitrate=double(),
                                     ID=integer() )

        ## not going to do any exception handling here; assume
        ## directory exists, files are readable 

        datafiles <- (list.files(path=directory))
        
        for (fileName in datafiles) {

            fileName <- paste(directory, '/', fileName, sep = '')

            ## print(read.csv(fileName))
            pollutantData <- rbind (pollutantData,
                                   read.csv(fileName))
        }

        pollutantData

    }

    poluttantData <- readdata(directory = directory)
    r <- numeric(0)
    
    IDs <- unique(poluttantData$ID)

    for ( id in IDs ) {
        candidate <- poluttantData[ poluttantData$ID==id, ]
        completeData <- candidate [ ! ( is.na(candidate$sulfate)
                                       | is.na(candidate$nitrate)
                                       ),]
        if ( nrow ( completeData ) >= threshold ) {
             r <- c(r, cor( completeData$sulfate, completeData$nitrate))
        }
    }
    
    r
}
