setwd("D:/coursera/4 Exploratory Data Analysis")

fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "power.zip")
unzip("power.zip")
require(data.table)
data<-fread("household_power_consumption.txt", sep = ";", header = TRUE,na.strings = "?")
head(data,1)

#install.packages("sqldf")
require(sqldf)
newdata <- sqldf("select * FROM data WHERE Date='1/2/2007'or Date='2/2/2007'")
nrow(newdata)
head(newdata,1)

newdata$newdate<-paste(newdata$Date,newdata$Time)
newdata$newdatetime<-strptime(newdata$newdate,format = "%d/%m/%Y %H:%M:%S")     
head(newdata)
#################################################################
png(file="plot3.png",width = 480, height = 480)
with(newdata,plot(newdatetime,Sub_metering_1,xlab="",
     ylab="Energy sub metering",col="black",type="l"))
with(newdata,lines(newdatetime,Sub_metering_2,col="red"))
with(newdata,lines(newdatetime,Sub_metering_3,col="blue"))     
legend("topright", lty=1, cex=0.7,col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()



