#load data
EI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
years <- unique(NEI$year)

png(filename="./plot5.png")
barplot(sapply(years,
         function(x) sum(NEI[NEI$year == x &
          NEI$SCC %in% as.character(SCC[ grep('[Vv]ehicle',SCC$Short.Name),]$SCC) &
	  NEI$fips == "24510", ]$Emissions)),
    names=years,
    ylab="emissions, tons",
    main="Motor Vehicle-related emissions in Baltimore City")
dev.off()

# Memo:
# same as previous, with different search sting and 
# additional filter by FIPS
