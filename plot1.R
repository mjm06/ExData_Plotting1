#This script reads in a subset of the text file household_power_consumption and creates a histogram
#of global active power (kilowatts).Because only data for 2007-02-01 and 2007-02-02 (2 days) are needed, 
#and the original txt file is over 2 million rows in length, we pull just the necessary rows.
#Note that the dates are given as dd/mm/yyyy in the original dataset.

#Here I assume that the file household_power_consumption.txt is located within the working directory, so only relative paths
#are given for this .txt file.

first5rows<-read.table("household_power_consumption.txt", header=TRUE, sep=";", nrows=5, stringsAsFactors=FALSE)
classes<-sapply(first5rows, class)
all.data<-read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, colClasses=classes, na.strings="?")

#pull only those rows that contain data for Feb 1 and Feb 2 of 2007.
sub.data<-all.data[((all.data$Date=="2/2/2007")|(all.data$Date=="1/2/2007")), ]


hist(sub.data$Global_active_power, col="red", xlab="Global Active Power (Kilowatts)", main="Global Active Power")
dev.copy(png, 'plot1.png')
dev.off()
