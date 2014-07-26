require(ggplot2)

if(!exists("NEI")) NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
  if(!exists("SCC")) SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

    years <- 1999:2008

  pollutant <- "PM25-PRI"

  data <- NEI[NEI$year %in% years & NEI$Pollutant == pollutant & NEI$fips == "24510",]

  aggData <- data.frame(tapply(data$Emissions,list(data$year,data$type),sum))
  finalAggData <- data.frame(matrix(vector(), 16, 3, dimnames=list(c(), c("Year", "Type", "TotalEmissions"))), stringsAsFactors=F)
  i <- 1
  for (c in colnames(aggData))
   for (r in rownames(aggData)){
    finalAggData[i,] <- c(r,c,aggData[r,c])
    i <- i+1
  }

  png("./export/plot3.png", height=768, width=768)
  plt <- ggplot(finalAggData, aes(x=factor(Year), y=as.numeric(TotalEmissions), fill=Type)) +
  geom_bar(stat="identity") +
  facet_wrap(~ Type, ncol=2) +
  xlab("Year") +
  ylab(expression("TTotal PM²⁵ emission")) +
  ggtitle(expression("Total PM²⁵ emission in Baltimore City (1999 - 2008) by source type")) +
  theme(plot.title = element_text(color="red", size=18, vjust=1.0))
  print(plt)
  dev.off()
