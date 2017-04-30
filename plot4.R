# All code for reading data is commented out here
# because in the first script I saved the file I wanted to load
# so you can just scroll down to the "load" step unless you want to check
# for reproducibility

# library(lubridate)
# library(dplyr)
# 
# # download and unzip the data
# fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download.file(fileurl, "power.zip")
# unzip("power.zip")
# 
# 
# # read in file; read all columns as characters
# power <- read.delim("household_power_consumption.txt", 
#                     header=TRUE, sep=";", 
#                     colClasses = "character")
# 
# # turn Date into a date and subset for Feb 1-2, 2007
# power$date <- dmy(power$Date)
# power2 <- filter(power, date >= "2007-02-01" & date <= "2007-02-02")
# 
# # make a DateTime column, which might help with graphing
# # (this is why I kept the original "Date" column)
# power2$DateTime <- dmy_hms(paste(power2$Date, power2$Time), tz="America/Los_Angeles")
# 
# # get rid of the original Date and Time columns to avoid confusion
# power2 <- select(power2, -Date, -Time)
# 
# # and for a backup, make "power" the smaller, subsetted "power2"
# power <- power2
# 
# # are there any ?s in here anywhere that need to be turned into "NA"s
# for (i in 1:7) {
#     a <- grep("//?", power2[ , i])
#     print(a)
# }
# # nope
# 
# # so just turn them all into numeric columns
# for (i in 1:7) {
#     power2[ , i] <- as.numeric(power2[ , i])
# }
# 
# # save this for use in the other plot scripts
# save(power2, file = "power2.R")
# 

# here's the starting point for plot 4----
load("power2.R")

png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfcol = c(2, 2))
with(power2, {
    plot(Global_active_power ~ DateTime, 
         type = "l",
         xlab = "",
         ylab = "Global Active Power (kilowatts)")
    
    plot(Sub_metering_1 ~ DateTime, 
         type = "l", col = "black",
         xlab = "",
         ylab = "Energy sub metering")
    lines(Sub_metering_2 ~ DateTime, col = "red")
    lines(Sub_metering_3 ~ DateTime, col = "blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"), 
           lty=1, bty = "n")
    
    plot(Voltage ~ DateTime, type = "l",
         xlab = "datetime",
         ylab = "Voltage")
    
    plot(Global_reactive_power ~ DateTime, type = "l",
         xlab = "datetime",
         ylab = "Global_reactive_power")
})


dev.off()