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
png("./plot3.png", height=480,width=480)
'Create empty plot with axis labels'
plot(usable_data$DateTime,usable_data$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering")
'write in the lines for different sub meters as a function of date time'
lines(usable_data$DateTime,usable_data$Sub_metering_1)
lines(usable_data$DateTime,usable_data$Sub_metering_2, col="red")
lines(usable_data$DateTime,usable_data$Sub_metering_3, col="blue")
'Write in legend'
legend("topright", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
'turn off dev.'
dev.off()