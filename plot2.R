rm(list = ls())
############################### Prepare the data #####################################

## original data set download link
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

unzip ("exdata-data-household_power_consumption.zip", exdir = ".")

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

############################### Plot 2 #####################################

# highly recomend png() to copy the plot, because dev2copy() does not save a 100% identical image
png(filename = "plot2.png", width = 480, height = 480)

plot( selected_data$fulldate, selected_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()
