#This script reads in a subset of the text file household_power_consumption.
#Then, the script plots Global_active_power (electricity useage in kilowatts) over time for
#two days, Feb. 1 and Feb. 2, 2007. The plot is saved to the working directory as a .png.

#Because only data for 2007-02-01 and 2007-02-02 (2 days) are needed, 
#and the original txt file is over 2 million rows in length, we pull just the necessary rows.
#Note that the dates are given as dd/mm/yyyy in the original dataset.

#Here I assume that the file household_power_consumption.txt is located within the working directory.

first5rows<-read.table("household_power_consumption.txt", header=TRUE, sep=";", nrows=5, stringsAsFactors=FALSE)
classes<-sapply(first5rows, class)
all.data<-read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, colClasses=classes, na.strings="?")

#pull only those rows that contain data for Feb 1 and Feb 2 of 2007.
sub.data<-all.data[((all.data$Date=="2/2/2007")|(all.data$Date=="1/2/2007")), ]

#Need to convert the Date and Time columns to R formatted dates and times.
datetime<-paste(sub.data$Date, sub.data$Time)
datetime<-format(datetime, format="%d/%m/%Y %H:%M:%S", usetz=FALSE)
datetime<-as.POSIXlt(datetime, format="%d/%m/%Y %H:%M:%S")

#Put the pasted and converted day and time in the sub dataset.
sub.data<-cbind(datetime, sub.data)


#Plot time series of Global_active_power data. List the x-axis (time), then the y-axis values.
plot(sub.data$datetime, sub.data$Global_active_power, type="l", ylab="Global Active Power (Kilowatts)", xlab=" ")

dev.copy(png, 'plot2.png')
dev.off()
