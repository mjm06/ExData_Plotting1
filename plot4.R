#This script reads in a subset of the text file household_power_consumption.
#Because only data for 2007-02-01 and 2007-02-02 (2 days) are needed, 
#and the original txt file is over 2 million rows in length, we pull just the necessary rows.
#Note that the dates are given as dd/mm/yyyy in the original dataset.
#Here I assume that the household_power_consumption.txt is in the working directory, so I use
#relative paths for this file in the script.
#The script creates a 2x2 matrix of plots (four plots in all), and outputs them as a single .png file.

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

#Create multiple base plots: starting from upper left and going CW, these plots are:
#Global Active Power vs time (Plot 2)
#Voltage vs time
#Global reactive power
#Sub_metering_1, _2, and _3 vs time (Plot 3).

par(mfrow=c(2,2))
plot(sub.data$datetime, sub.data$Global_active_power, type="l", xlab=" ", ylab="Global_Active_Power")
plot(sub.data$datetime, sub.data$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(sub.data$datetime, sub.data$Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab=" ")
lines(sub.data$datetime, sub.data$Sub_metering_2, type="l", col="red")
lines(sub.data$datetime, sub.data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1),
              lwd=c(2.5,2.5), bty='n', col=c("black", "red", "blue"))
plot(sub.data$datetime, sub.data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")


dev.copy(png, 'plot4.png')
dev.off()
