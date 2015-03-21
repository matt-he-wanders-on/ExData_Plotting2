#plot1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008. 
# Upload a PNG file containing your plot addressing this question.


library(plyr)

NEI <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS("C:\\Users\\MATTHEW\\Desktop\\ExData_Plotting2\\exdata_data_NEI_data\\Source_Classification_Code.rds")

#Aggregate and sum the emissions by year
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year")


# Plot file with dimensions 480x480
png(filename = "plot1.png",width = 480, height = 480)
plot(byYear, type ="b", xlab="Year",ylab="PM2.5 Emissions",main="",col="red", pch =4)

dev.off()