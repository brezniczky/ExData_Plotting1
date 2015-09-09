# clear the workspace
rm(list = ls())

# set working directory
# setwd("E:/Coursera/Exploratory Data Analysis (for badge)/Project 1/exdata_data_household_power_consumption")

raw.csv = read.csv("household_power_consumption.txt", sep = ";", 
                   stringsAsFactors = FALSE)
# narrow down to the really relevant periods
date.match = !is.na(match(raw.csv$Date, c("1/2/2007", "2/2/2007")))
csv = raw.csv[date.match, ]

# parse columns
#
class(csv$Sub_metering_1) <-"numeric"
class(csv$Sub_metering_2) <-"numeric"
class(csv$Sub_metering_3) <-"numeric"
class(csv$Global_active_power) <- "numeric"
# coalesce the date and time columns into a single parsed column
csv <- cbind(csv,
             DateTime = strptime(paste0(csv$Date, csv$Time), 
                                 format = "%d/%m/%Y %H:%M:%S"))

par(mfrow = c(1, 1), cex = 0.8)
plot(
  csv$DateTime, csv$Global_active_power, type = "l",
  ylab = "Global Active Power (kilowatts)",
  xlab = ""
)


# chart 4: 4 charts in one
par(mfrow = c(2, 2), cex = 0.6)
plot(csv$DateTime, csv$Global_active_power, 
     ylab = "Global Active Power", xlab = "", type = "l")
plot(csv$DateTime, csv$Voltage, ylab = "Voltage", xlab = "datetime", 
     type = "l")

plot(csv$DateTime, csv$Sub_metering_1, type = "l", col = "black", 
     ylab = "Energy sub metering", xlab = "")
lines(csv$DateTime, csv$Sub_metering_2, col = "red")
lines(csv$DateTime, csv$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n", xjust = 1)

plot(csv$DateTime, csv$Global_reactive_power, xlab = "datetime", 
     ylab = "Global_reactive_power", type = "l")
