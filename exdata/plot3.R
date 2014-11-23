# load ggplot2
library(ggplot2)

# load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
years <- unique(NEI$year)

# aggregates per type
a <- data.frame(yr = numeric(), type = character(), emissions=numeric(), stringsAsFactors=F)
for (year in unique(NEI$year)) {
  for (type in unique(NEI$type)) {
    a[nrow(a)+1,] <- list(year=year,type=type,
                          emissions=sum( NEI[ NEI$year == year & NEI$fips == 24510 & NEI$type == type, ]$Emissions ) )
  }
}

# plot
ppi=200
png(filename="./plot3.png", width=4.5*ppi, height=2.55*ppi)
print(ggplot(a) + geom_area(aes(x=yr,y=emissions,fill=type)) +ggtitle("Emissions per type in Baltimore City"))
dev.off()

