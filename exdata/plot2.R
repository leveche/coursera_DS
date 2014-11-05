NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
years <- unique(NEI$year)

png(filename="./plot2.png")
barplot(sapply(years,function(x) sum(NEI[NEI$year == x & NEI$fips == 24510,]$Emissions)/1e3 ), 
	names =years,
	ylab="total PM2.5 emission from all sources, Thousands of Tons",
	main="PM2.5 emissions by year - Baltimore")
dev.off()
