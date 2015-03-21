#plot 4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
#Upload a PNG file containing your plot addressing this question.


library(plyr)
library(ggplot2)

NEI <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\Source_Classification_Code.rds")

#Find all entries in the SCC file containing 'coal'
coalIdx<-grep("coal",tolower(SCC$Short.Name),fixed = TRUE)
SCC<-SCC[coalIdx,c("SCC","Short.Name")]

#Check the NEI data for these entries
NEI<-merge(NEI, SCC, by="SCC")

#Aggregate by year and get the total emissions
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year", "count")

#Scale the emissions to thousands for better display
#byYear$count<-round(byYear$count/1000)

#Plot file with dimensions 480x480
png(filename = "plot4.png",width = 480, height = 480)
g<-ggplot(data=byYear, aes(x=year, y=count)) + 
  geom_line() + geom_point(aes(size=2)) + 
  ggtitle('Total Emissions of PM2.5 from Coal Combustion in the US') + 
  ylab('PM2.5 Emissions (in thousands)') + xlab('Year') + 
  geom_text(aes(label=round(count,digits=0), size=2, hjust=1.5, vjust=1.5))
print(g)

dev.off()