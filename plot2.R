if(!exists("NEI")) NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

years <- 1999:2008

pollutant <- "PM25-PRI"

data <- NEI[NEI$year %in% years & NEI$Pollutant == pollutant & NEI$fips == "24510",]

aggData <- tapply(data$Emissions,data$year,sum)
finalAggData <- data.frame(matrix(vector(), 4, 2, dimnames=list(c(), c("TotalEmissions", "Year"))), stringsAsFactors=F)
finalAggData$TotalEmissions <- as.numeric(aggData)
finalAggData$Year <- names(aggData)

png("./export/plot2.png")
plot(finalAggData$Year,finalAggData$TotalEmissions, type = "l", ylab = "Total Emissions", xlab = "Year", main = "Total PM²⁵ emissions in Baltimore City (1999 - 2008)")
dev.off()