## plot3.R


power_table <- read.table("~/R/household_power_consumption.txt", 
                          sep = ";", na.strings = "?",
                          skip = 66636, nrows = 2880)

## See plot1.R to understand why we use these arguments.

header <- read.table("~/R/household_power_consumption.txt", 
                     sep = ";", na.strings = "?", header = TRUE, nrows = 1)
##
## Gives a small table we can then read the colnames from

colnames(power_table) <- colnames(header)
##
## Concatenate $Date and $Time as $DateTime and then into POSIXct
##
power_table$DateTime <- paste(power_table$Date, power_table$Time, sep = " ")
power_table$DateTime <- strptime(power_table$DateTime, "%d/%m/%Y %H:%M:%S")


## Plot #3: Overlay multiple plots (stair steps) on one set of axes
##
png(filename = "plot3.png")
## Initialize a png graphics device


plot(power_table$DateTime, power_table$Sub_metering_1,  
     type = "s",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     col = 1)

## Additional data from the other sub meterings

points(power_table$DateTime, power_table$Sub_metering_2,  type = "s", col = 2)
points(power_table$DateTime, power_table$Sub_metering_3,  type = "s", col = 4)

## Place figure legend in topright.

legend(x = "topright", y = NULL,
       
       legend = 
               c("Sub_metering_1",
                 "Sub_metering_2",
                 "Sub_metering_3"),
       
       lty = 1, col = c(1,2,4))

## Line thickness is 1, and colored corresponding to each sub meter.

dev.off()
## Close the png graphics device