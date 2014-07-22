if(!exists("NEI")){
	NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
	SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
}

years <- c(1999,2002,2005,2008)

pollutant <- "PM25-PRI"

data <- NEI[NEI$year %in% years & NEI$Pollutant == pollutant,]

aggData <- tapply(data$Emissions,data$year,sum)
finalAggData <- data.frame(matrix(vector(), 4, 2, dimnames=list(c(), c("TotalEmissions", "Year"))), stringsAsFactors=F)
finalAggData$TotalEmissions <- as.numeric(aggData)
finalAggData$Year <- names(aggData)

png("./export/plot1.png")
plot(finalAggData$Year,finalAggData$TotalEmissions, type = "l", ylab = "Total Emissions", xlab = "Year", main = "Total PM²⁵ emissions (1999 - 2008)")
dev.off()