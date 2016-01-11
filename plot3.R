#Read data & understand variable types:
datafile<- "./data/household_power_consumption.txt"
data <- read.table(datafile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#Convert Date variable from chr to Date format
data$Date<- as.Date(data$Date, format="%d/%m/%Y")

#Subset the data:
#library(dplyr)
subsetData<- data%>%
        filter(Date >= "2007-02-01" & Date <= "2007-02-02")

# Combining date & time
datetime<- paste(as.Date(subsetData$Date), subsetData$Time)
subsetData$Datetime <- as.POSIXct(datetime)

#Covert chr to numeric data type:
subsetData$Global_active_power<- as.numeric(subsetData$Global_active_power)
subsetData$Global_reactive_power<- as.numeric(subsetData$Global_reactive_power)
subsetData$Sub_metering_1<- as.numeric(subsetData$Sub_metering_1)
subsetData$Sub_metering_2<- as.numeric(subsetData$Sub_metering_2)
subsetData$Sub_metering_3<- as.numeric(subsetData$Sub_metering_3)

###############################################################################

#Plot3:
plot(subsetData$Datetime, subsetData$Sub_metering_1, type="l", xlab="", ylab="Energy Submetering")
lines(subsetData$Datetime, subsetData$Sub_metering_2, type="l", col="red")
lines(subsetData$Datetime, subsetData$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"), cex=1)
dev.copy(png, file="plot3.png",  height=480, width=480)
dev.off()
