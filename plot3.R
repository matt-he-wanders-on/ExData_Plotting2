# Plot 3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
#Upload a PNG file containing your plot addressing this question.




library(plyr)
library(ggplot2)

NEI <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\Source_Classification_Code.rds")

#Only data for Baltimore
NEI <- NEI[NEI$fips=="24510",]

#Aggregate by year & type, getting total emissions
byYearAndType<-ddply(NEI,c("year","type"),function(row) sum(row$Emissions))
colnames(byYearAndType)<-c("year", "type", "count")

##Change the year to char for better display
byYearAndType$year<-as.character(byYearAndType$year)

# Plot file 
png(filename = "plot3.png",width = 640, height = 640)
g<-ggplot(data=byYearAndType, aes(x=year, y=count)) + facet_grid(. ~ type) + guides(fill=F) +
  geom_bar(aes(fill=type),stat="identity") +
  ylab('PM2.5 Emissions') + xlab('Year') + 
  ggtitle('Emissions By Type in Baltimore') + geom_jitter(alpha=0.10)
print(g)

dev.off()