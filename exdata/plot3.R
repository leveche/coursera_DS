NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
years <- unique(NEI$year)

library(ggplot2)


a <- data.frame(yr = numeric(), type = character(), emissions=numeric(), stringsAsFactors=F)
for (year in unique(NEI$year)) {
  for (type in unique(NEI$type)) {
    a[nrow(a)+1,] <- list(year=year,type=type,
                          emissions=sum( NEI[ NEI$year == year & NEI$fips == 24510 & NEI$type == type, ]$Emissions ) )
  }
}

png(filename="./plot3.png")
p <- qplot(yr,emissions, fill=type, color=type, data=a, geom=c("area"), ylab="Emissons, tons", xlab="year", main="Emissions per type in Baltimore City" )
ggsave(filename="./plot3.png",plot=p,scale=0.4)
dev.off()
