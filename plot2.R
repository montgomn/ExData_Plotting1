## plot2.R


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

## Produce Line Graph for Plot #2

png(filename = "plot2.png")
## initialize a png graphics device.

plot(power_table$DateTime, 
     power_table$Global_active_power,
     
     ## plot active power (Arg 2) vs. Time (Arg 1)
     
     type = "l",
     
     ## Specifies a line graph 
     
     xlab = "",
     
     ## x-Axis should be unlabeled
     
     ylab = "Global Active Power (kilowatts)"
)
     
dev.off()
## Close the png graphics device.
     