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

    ## Given a vector monitor ID numbers, 'pollutantmean' reads that
    ## monitors' particulate matter data from the directory specified in
    ## the 'directory' argument and returns the mean of the pollutant
    ## across all of the monitors, ignoring any missing values

    ## 'pollutant' is a character of length 1 indicating
    ## the name of the pollutant  we will calculate the
    ## mean; either "sulfate" or "nitr

    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used

    ##  the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)

    

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
    
    mean(pollutantData[,pollutant],na.rm=TRUE)
}
