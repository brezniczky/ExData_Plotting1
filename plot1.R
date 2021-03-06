# clear the workspace
rm(list = ls())

# set working directory
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
class(csv$Global_active_power) <- "numeric"
# coalesce the date and time columns into a single parsed column
csv <- cbind(csv,
             DateTime = strptime(paste0(csv$Date, csv$Time), 
                                 format = "%d/%m/%Y %H:%M:%S"))

par(mfrow = c(1, 1), cex = 0.8)
hist(csv$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")

# save the chart to PNG
dev.copy(png, file = "../repo/ExData_Plotting1/plot1.png")
# close the PNG device
dev.off()
dev.off() # comment out/remove this line to keep the chart on screen
