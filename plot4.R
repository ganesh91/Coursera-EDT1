# Read the CSV to Subset Table variable
stble <- read.csv("household_power_consumption.txt",header = TRUE,sep = ";",na.strings="?")
# Flter the data for specified dates
stble <- stble[which(stble[,1]=='1/2/2007'|stble[,1]=='2/2/2007'),]
# Remove NAs
stble <- stble[complete.cases(stble),]
# Logic for converting things to date-time class
vdates <- stble[,1]
vtimes <- stble[,2]
z <- paste(vdates,vtimes)
calender <- as.POSIXlt(strptime(z,"%d/%m/%Y %H:%M:%S"),tz = "")
# Also add a column day which would have char of 4 dates of date
dataset <- data.frame(calender,day=substr(weekdays(calender),1,3),stble[,3:9])
#open graphics and write Graphics
png("plot4.png",height=480,width=480)
par(mfrow = c(2,2),mar = c(4,4,1,1))
plot(dataset$calender,dataset$Global_active_power,type="l",main="",xlab="",ylab="Global Active Power")
plot(dataset$calender,dataset$Voltage,type="l",xlab = "datetime",ylab = "Voltage")
plot(dataset$calender,dataset$Sub_metering_1,type="l",main="",xlab="",ylab="Energy sub metering")
lines(dataset$calender,dataset$Sub_metering_2,col="red")
lines(dataset$calender,dataset$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,cex = 0.9,box.col = NULL,box.lwd=0,box.lty = 0,inset = 0.01)
plot(dataset$calender,dataset$Global_reactive_power,type="l",xlab = "datetime",ylab="Global_reactive_power")
dev.off()
