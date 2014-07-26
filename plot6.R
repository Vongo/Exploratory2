library(ggplot2)

revertFips <- function(x) if (grepl("24510",x)) "Baltimore City" else if (grepl("06037",x)) "Los Angeles County" else "OTHER"

if(!exists("NEI")) NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
  if(!exists("SCC")) SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

    data <- NEI[(NEI$fips=="24510" | NEI$fips=="06037") & NEI$type=="ON-ROAD",]

  aggData <- data.frame(tapply(data$Emissions,list(data$year,data$fips),sum))
  finalAggData <- data.frame(matrix(vector(), 0, 3, dimnames=list(c(), c("Year", "City", "TotalEmissions"))), stringsAsFactors=F)
  i <- 1
  for (c in colnames(aggData))
   for (r in rownames(aggData)){
    finalAggData[i,] <- c(r,revertFips(c),aggData[r,c])
    i <- i+1
  }

  png("./export/plot6.png", height=768, width=768)
  plt <- ggplot(finalAggData, aes(x=factor(Year), y=as.numeric(TotalEmissions), fill=City)) +
  geom_bar(stat="identity") +
  facet_wrap(~ City, ncol=2,scales="free_y") +
  xlab("Year") +
  ylab(expression("TTotal PM²⁵ emission")) +
  ggtitle(expression("Total PM²⁵ emission in LA and Baltimore City (1999 - 2008) for motor vehicles")) +
  theme(plot.title = element_text(color="red", size=18, vjust=1.0))
  print(plt)
  dev.off()

# The layout is foolish, because the y axis is not ordered (min value is in max)
# This issue is due to the scale difference between the two cities, which ggplot can't manage properly.
# I spent a lot of time trying to fix this, but couldn't.
# The result is right though, as long as you can read the axis scale. But it is not clear.