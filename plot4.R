rm(list = ls())
############################### Prepare the data #####################################

# read the data file
data <- read.csv("./household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)

# convert variable 3~9 to numeric
data[,3] <- as.numeric(data[,3])
data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])
data[,6] <- as.numeric(data[,6])
data[,7] <- as.numeric(data[,7])
data[,8] <- as.numeric(data[,8])
data[,9] <- as.numeric(data[,9])


# we will use dplyr's mutate to add a variable that combine the date and time
library(dplyr)
data <- mutate(data, fulldate = paste(data[,1], data[,2]))

# convert the new date time variable to Date/Time type
data$fulldate <- strptime(data$fulldate, "%d/%m/%Y %H:%M:%S")

# subset the data that falls in 2007-02-01 and 2007-02-02
selected_data <- data[data$fulldate > "2007-02-01" & data$fulldate < "2007-02-03", ]

############################### Plot 4 #####################################

# highly recomend png() to copy the plot, because dev2copy() does not save a 100% identical image
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 2), oma = c(1, 1, 1, 1))

with(selected_data, {
  
  # set type = "l" to plot lines, instead of points
  plot(fulldate, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  
  plot(fulldate, Voltage, type = "l", xlab = "datetime")

  plot(fulldate, Sub_metering_1, type = "l", col = "Black", xlab = "", ylab = "Energy sub metering")
  lines(fulldate, Sub_metering_2, type = "l", col = "Red")
  lines(fulldate, Sub_metering_3, type = "l", col = "Blue")
  
  ## set bty = "n" to remove the legend border
  legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  

  plot(fulldate, Global_reactive_power, type = "l", xlab = "datetime")
})

dev.off()
