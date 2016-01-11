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

#Plot1:
hist(subsetData$Global_active_power, main="Global Active Power", xlab="Global Active Powe (kilowatts)", ylab="Frequency", col="Red")
dev.copy(png, file="plot1.png",  height=480, width=480)
dev.off()
