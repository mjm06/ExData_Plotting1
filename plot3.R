#This script reads in a subset of the text file household_power_consumption.
#Because only data for 2007-02-01 and 2007-02-02 (2 days) are needed, 
#and the original txt file is over 2 million rows in length, we pull just the necessary rows.
#Note that the dates are given as dd/mm/yyyy in the original dataset.
#The script plots energy sub metering over time for three 'zones' of a house (kitchen appliances,
#laundry appliances, and water heater and A/C), on the same x-y axes. 

#Here I assume that household_power_consumption.txt is housed in the working directory, so only relative
#path are used for this .txt file in the script.
first5rows<-read.table("household_power_consumption.txt", header=TRUE, sep=";", nrows=5, stringsAsFactors=FALSE)
classes<-sapply(first5rows, class)
all.data<-read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, colClasses=classes, na.strings="?")

#pull only those rows that contain data for Feb 1 and Feb 2 of 2007.
sub.data<-all.data[((all.data$Date=="2/2/2007")|(all.data$Date=="1/2/2007")), ]

#Need to convert the Date and Time columns to R formatted dates and times.
datetime<-paste(sub.data$Date, sub.data$Time)
datetime<-format(datetime, format="%d/%m/%Y %H:%M:%S", usetz=FALSE)
datetime<-as.POSIXlt(datetime, format="%d/%m/%Y %H:%M:%S")

#Put the pasted day and time in the sub dataset.
sub.data<-cbind(datetime, sub.data)

#Plot time series of Energy sub metering_1 (kitchen), _2 (laundry room), and _3 (electric water heater 
#and A/C). Add a legend showing the line color used for each (black, red, and blue, respectively).
plot(sub.data$datetime, sub.data$Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab=" ")
lines(sub.data$datetime, sub.data$Sub_metering_2, type="l", col="red")
lines(sub.data$datetime, sub.data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1),
lwd=c(2.5,2.5), col=c("black", "red", "blue"))

dev.copy(png, 'plot3.png')
dev.off()
