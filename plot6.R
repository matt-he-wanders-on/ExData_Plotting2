#plot 6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037).
#Which city has seen greater changes over time in motor vehicle emissions?
#Upload a PNG file containing your plot addressing this question.


library(plyr)
library(ggplot2)

NEI <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\Source_Classification_Code.rds")

#Need 'ON-ROAD' data for Baltimore & Los Angeles
NEI <- NEI[NEI$type == 'ON-ROAD',]
NEI <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]
#NEI <- NEI[NEI$type == 'ON-ROAD' & NEI$fips=="24510" | NEI$fips=="06037",]


#Aggregate by year & location, then get total emissions
byYearAndFips<-ddply(NEI,c("year","fips"),function(row) sum(row$Emissions))

#For display purposes, we can set proper labels rather than using fips data
byYearAndFips[byYearAndFips$fips=='06037',]$fips<-"Los Angeles"
byYearAndFips[byYearAndFips$fips=='24510',]$fips<-"Baltimore"
colnames(byYearAndFips)<-c("year", "city", "count")

#Scale the emissions to be the log value so there's less extreme difference bewteen them
byYearAndFips$count<-log(byYearAndFips$count)

#Plot file with dimensions 480x480
png(filename = "plot6.png",width = 480, height = 480)
g<-ggplot(byYearAndFips, aes(x=year, y=count, color = city)) 
g<-g + geom_line(aes(width=3.0)) + xlab("Year") + ylab("log PM2.5 Emissions")
g<-g + ggtitle('    Motor Vehicle Emissions of PM2.5 in Baltimore and Los Angeles') 
g<-g + theme_bw()
print(g)

