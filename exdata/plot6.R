#load data
EI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
years <- unique(NEI$year)

# All SCC codes containing 'motor' or 'vehicle' in the description
MotorVehicleCodes <- unique(unlist(sapply(
		c("[Mm]otor","[Vv]ehicle"), 
		function(x) as.character(SCC[ grep(x,SCC$Short.Name),]$SCC)
	),
	use.names=FALSE))


# calculate aggregate emissions for both FIPS
a <- data.frame(yr = numeric(), fips = integer(), emissions=numeric(), stringsAsFactors=F)

for (year in unique(NEI$year)) {
  for (fips in c("06037","24510")) {
	a[nrow(a)+1,] <- list(year=year,fips=fips,
     		emissions=sum( 
			NEI[ NEI$year == year & 
				NEI$fips == fips & 
				NEI$SCC %in% codes, ]$Emissions 
		) )
	}
}

# normalize values for both FIPS codes to their respective 1999 levels 
for (fips in unique(a$fips)) {a$emissions[a$fips == fips] <- a$emissions[a$fips==fips]/a$emissions[a$fips == fips & a$yr == 1999]}


#plot
ppi=170
png(filename="./plot6.png", width=4.5*ppi, height=2.55*ppi)
print(ggplot(a) 
	+ geom_bar( stat='identity',position='dodge')
	+ aes(x=yr,y=emissions,fill=fips)
	+ ggtitle("Changes in Motor Vehicle-related Emissions in Baltimore and LA County")
	+ xlab("year")
	+ ylab("emissions relative to 1999 levels") )
dev.off()

# Memo:
# same as previous, with different search sting and 
# additional filter by FIPS
