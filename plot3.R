plot3<- function(){
##load required libraries
#
        
##fetch the dataset unless I already have it
if(!file.exists("./electric")){dir.create("./electric")}
fileloc <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./electric/dataset.zip")){download.file(fileloc, destfile = "electric/dataset.zip")}
        
##extract the datasets from the zip unless I've already done it
if(!file.exists("./electric/household_power_consumption.txt")){
unzip(zipfile = "./electric/dataset.zip", exdir = "./electric")}

##read in the file
electric <- read.csv("./electric/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
febelectric <- subset(electric, Date=="1/2/2007"|Date=="2/2/2007")

##tidy up time
febelectric$DateTime <- paste(febelectric$Date, febelectric$Time)
febelectric$DateTime <- strptime(febelectric$DateTime,  "%d/%m/%Y %H:%M:%S", tz = "Europe/Paris")
#febelectric$Weekday <- weekdays(febelectric$DateTime)

##create plot 3
png(filename="plot3.png",  height = 480, width = 480)
with(febelectric, plot(DateTime, Sub_metering_1, type="l", ylab = "Energy Submetering", xlab=""))
points(febelectric$DateTime,febelectric$Sub_metering_2, col="red", type="l")
points(febelectric$DateTime,febelectric$Sub_metering_3, col="blue", type="l")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)
dev.off()
}