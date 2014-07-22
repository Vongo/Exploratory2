library(plyr)

if(!exists("NEI")){
	NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
	SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
}

years <- 1999:2008

scCoal <- SCC[grepl("coal", tolower(SCC$EI.Sector)),]

data <- join(scCoal, NEI, by="SCC", type="inner")

aggData <- data.frame(tapply(data$Emissions,data$year,sum))
finalAggData <- data.frame(matrix(vector(), 4, 2, dimnames=list(c(), c("TotalEmissions", "Year"))), stringsAsFactors=F)
finalAggData$TotalEmissions <- as.numeric(aggData[,1])
finalAggData$Year <- rownames(aggData)

png("./export/plot4.png")
plot(finalAggData$Year,finalAggData$TotalEmissions, type = "l", ylab = "Total Emissions", xlab = "Year", main = "Total PM²⁵ emissions in Baltimore City (1999 - 2008)")
dev.off()