t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date and filter from February 1, 2007 to February 2, 2007
t$Date <- as.Date(t$Date, "%d/%m/%Y")
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
t <- t[complete.cases(t),]

## Combine Date and Time column
dateTime <- paste(t$Date, t$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
t <- t[ ,!(names(t) %in% c("Date","Time"))]

## Add and format DateTime column
t <- cbind(dateTime, t)
t$dateTime <- as.POSIXct(dateTime)

## Save file and close device
png("plot1.png", width=480, height=480)

## Create the histogram
hist(t$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.off()

