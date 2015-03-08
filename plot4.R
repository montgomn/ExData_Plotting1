## plot4.R


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
##
##

## Plot #4, multiple plots in one figure.
png(filename = "plot4.png")
## Initialize a png graphics device

par(mfrow = c(2,2))
## 2 x 2 plot

## Upper Left Plot, Similar to Plot #2
plot(power_table$DateTime, 
     power_table$Global_active_power,
     
     ## plot active power (Arg 2) vs. Time (Arg 1)
     
     type = "l",
     
     ## Specifies a line graph 
     
     xlab = "",
     
     ## x-Axis should be unlabeled
     
     ylab = "Global Active Power"
     
)
## Upper Right Plot, similar to Plot #2
## but Voltage as dependent variable

plot(power_table$DateTime, power_table$Voltage,
     ylab = "Voltage",
     xlab = "datetime",
     type = "l")

## Lower Left
## Overlay multiple plots (stair steps) on one set of axes, 
## with a Figure legend as for Plot #3
##
plot(power_table$DateTime, power_table$Sub_metering_1,  
     type = "s",
     xlab = "",
     ylab = "Energy sub metering",
     col = 1)

## Additional data from the other sub meterings

points(power_table$DateTime, power_table$Sub_metering_2,  type = "s", col = 2)
points(power_table$DateTime, power_table$Sub_metering_3,  type = "s", col = 4)



legend(x = "topright", y = NULL, 
       
       bty = "n",

       ## No legend border

       legend = 
               c("Sub_metering_1",
                 "Sub_metering_2",
                 "Sub_metering_3"),
       
       lty = 1, col = c(1,2,4))



##
## Lower Right Plot, similar to Plot #2,
## but here Global_reactive_power is the dependent variable.

plot(power_table$DateTime, power_table$Global_reactive_power,
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = "l")
##

dev.off()
## Close the png graphics device.