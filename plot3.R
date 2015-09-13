# clear the workspace
rm(list = ls())

# set the working directory
# setwd("E:/Coursera/Exploratory Data Analysis (for badge)/Project 1/exdata_data_household_power_consumption")

# read up all the data
raw.csv = read.csv("household_power_consumption.txt", sep = ";", 
                   stringsAsFactors = FALSE)
# narrow down to the really relevant periods
date.match = !is.na(match(raw.csv$Date, c("1/2/2007", "2/2/2007")))
csv = raw.csv[date.match, ]
# save some memory
rm(raw.csv)

# parse columns
#
class(csv$Sub_metering_1) <-"numeric"
class(csv$Sub_metering_2) <-"numeric"
class(csv$Sub_metering_3) <-"numeric"
# coalesce the date and time columns into a single parsed column
csv <- cbind(csv,
             DateTime = strptime(paste0(csv$Date, csv$Time), 
                                 format = "%d/%m/%Y %H:%M:%S"))

png(filename = "../repo/ExData_Plotting1/plot3.png",
    width = 480, height = 480)

# the output contains one plot
par(mfrow = c(1, 1),
    cex = 0.8) # with a smaller font

# composite chart: 3 curves
plot(csv$DateTime, csv$Sub_metering_1, type = "l", col = "black", 
     ylab = "Energy sub metering", xlab = "")
lines(csv$DateTime, csv$Sub_metering_2, col = "red")
lines(csv$DateTime, csv$Sub_metering_3, col = "blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1,
       xjust = 1
       )
dev.off()
