setwd("D:/coursera/4 Exploratory Data Analysis")

fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "power.zip")
unzip("power.zip")
require(data.table)
data<-fread("household_power_consumption.txt", sep = ";", header = TRUE,na.strings = "?")
head(data,1)

install.packages("sqldf")
require(sqldf)
newdata <- sqldf("select * FROM data WHERE Date='1/2/2007'or Date='2/2/2007'")
nrow(newdata)
head(newdata,1)

newdata$newdate<-paste(newdata$Date,newdata$Time)
newdata$newdatetime<-strptime(newdata$newdate,format = "%d/%m/%Y %H:%M:%S")     
head(newdata)

###########################################################################
png(file="plot1.png",width = 480, height = 480)
hist(as.numeric(newdata$Global_active_power),
     col= "Red", main="Global Active Power",
     xlab="Global Active Power(kilowatts)",
     ylab="Frequency",ylim=c(0,1200))
dev.off()
