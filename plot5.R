library(ggplot2)

if(!exists("NEI")) NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# after reading https://class.coursera.org/exdata-004/forum/thread?thread_id=65 I picked "ON-ROAD" to represent "Motor vehicles"
nei <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",]

aggData <- tapply(nei$Emissions,nei$year,sum)
finalAggData <- data.frame(matrix(vector(), 4, 2, dimnames=list(c(), c("TotalEmissions", "Year"))), stringsAsFactors=F)
finalAggData$TotalEmissions <- as.numeric(aggData)
finalAggData$Year <- names(aggData)

png("./export/plot5.png", height=1024, width=1024)
qplot(x=finalAggData$Year,y=finalAggData$TotalEmissions,data=finalAggData,stat="identity",geom="histogram",ylab = "Total Emissions", xlab = "Year", main = "Total PM²⁵ emissions from motor vehicles in Baltimore City (1999 - 2008)")
dev.off()