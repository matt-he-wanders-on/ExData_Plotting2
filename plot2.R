# Plot 2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
#Upload a PNG file containing your plot addressing this question.



library(plyr)

NEI <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\Source_Classification_Code.rds")

#Only data for Baltimore
NEI <- NEI[NEI$fips=="24510",]

#Aggregate & sum emissions by year
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year","count")

# Plot file with dimensions 480x480
png(filename = "plot2.png",width = 480, height = 480)
plot(byYear, type ="b", xlab="Year",ylab="PM2.5 Emissions",main="Plot of PM2.5 Emissions By Year in Baltimore",col="red",pch=4)

dev.off()