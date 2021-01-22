'NEED TO HAVE /data SUBFOLDER CONTAINING DATA
OTHERWISE CANT RUN'
'Read in the data'
data<-read.table("./data/household_power_consumption.txt",header=TRUE,
                 sep=";", na.strings="?")

'Add in new DateTime variable corresponding to the date and time 
defined in the respective variables'
data$DateTime<-strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

'Subset data to only be the dates we care about. Also drop the
date and time variables'
usable_data<-subset(data[data$Date == "1/2/2007"|data$Date=="2/2/2007",], 
                    select=-c(Date, Time))

'open png to write the image to PNG'
png("./plot4.png", height=480,width=480)
par(mfcol=c(2,2), mar=c(4,4,4,4))
'Create first plot'
plot(usable_data$DateTime,usable_data$Global_active_power, 
     type="n", xlab="", ylab="Global Active Power")
lines(usable_data$DateTime,usable_data$Global_active_power)
'Create second plot'
plot(usable_data$DateTime,usable_data$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering")
lines(usable_data$DateTime,usable_data$Sub_metering_1)
lines(usable_data$DateTime,usable_data$Sub_metering_2, col="red")
lines(usable_data$DateTime,usable_data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty="n", lty=1, cex=0.75)
'Create third plot'
plot(usable_data$DateTime,usable_data$Voltage,
     type="n", xlab="datetime", ylab="Voltage")
lines(usable_data$DateTime,usable_data$Voltage)
plot(usable_data$DateTime,usable_data$Global_reactive_power, 
     type="n", xlab="datetime", ylab="Global_reactive_power")
lines(usable_data$DateTime,usable_data$Global_reactive_power)
'turn off dev.'
dev.off()