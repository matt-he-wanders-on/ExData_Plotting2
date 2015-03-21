#plot 5
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 
#Upload a PNG file containing your plot addressing this question.

library(plyr)
library(ggplot2)

NEI <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\Source_Classification_Code.rds")

#Only interested in Baltimore in 'ON-ROAD' data
NEI <- NEI[NEI$fips=="24510" & NEI$type == 'ON-ROAD',]

#Aggregate & sum by year
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year", "count")

#Plot file with dimensions 480x480
png(filename = "plot5.png",width = 480, height = 480)
g<-ggplot(data=byYear, aes(x=year, y=count)) + 
  geom_line() + geom_point(aes(size=2)) + 
  ggtitle('Total Emissions of PM2.5 from Motor Vehicle Sources in Baltimore City') + 
  ylab('PM2.5 Emissions (in thousands)') + xlab('Year') + 
  geom_text(aes(label=round(count,digits=0), size=2, hjust=1.5, vjust=1.5))
print(g)

dev.off()