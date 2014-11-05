NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
years <- unique(NEI$year)

png(filename="./plot1.png")
barplot(sapply(years,function(x) sum(NEI[NEI$year == x,]$Emissions)/1e6 ), 
    names = years, 
    ylab="total PM2.5 emission from all sources, Millions of Tons",
    main="PM2.5 emissions by year")
dev.off()
