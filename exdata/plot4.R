#load data
EI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
years <- unique(NEI$year)

png(filename="./plot4.png")
barplot(sapply(years,
         function(x) sum(NEI[NEI$year == x &
          NEI$SCC %in% as.character(SCC[ grep('[Cc]oal',SCC$Short.Name),]$SCC), ]$Emissions)/1e5),
    names=years,
    ylab="emissions, hundreds of thousand ton",
    main="total emissions from all coal-related sources")
dev.off()

# Memo:
# 1.
# as.character(SCC[ grep('oal',SCC$Short.Name),]$SCC)
# selects the emissions classification code from the SCC (description) code,
# where the description name matches 'Coal' or 'coal'
# 2.
# Thereafter, we built a 'join' between the SCC (descriptions) table 
# and the NEI table, on the key 'SCC', emissions classification code.
# 3.
# Aggregate the total emissions per year, from the filter above.
