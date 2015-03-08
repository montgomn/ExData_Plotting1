## plot1.R
##
## household_power_consumption.txt was examined using Notepad++ in Windows7
##
##
## Data are semicolon, i.e. ";" separated values
## We can use read.table(file = "household_power_consumption.txt, sep = ";") to load this file into memory.
## Additional arguments suggested by examination of file are shown below.
## 
##
## Reading data into atomic data classes for read.table
## has the benefit of reducing data processing steps, 
## as well as lowering memory usage.
##
## Data can be classed as it is read using the read.table()
## colClasses argument
##
## Column data, and appropriate types are described below. 
##
## $Date 
## dd/mm/yyyy
## $Time
## hh:mm:ss. Together with $Date, use POSIXct. 
## Need to import these as character for now.
##
## $Global_active_power & $Global_reactive_power
## numeric with three decimal places
##
## $Voltage
## numeric with two decimal places
##
## $Global_intensity 
## numeric with one decimal places
##
## $Sub_metering_1 & $Sub_metering_2 & $Sub_metering_3
## integer (but use numeric)
##
## "?" are specified as unknown values
## we should use the argument na.strings = "?"
##
## We wish to select values only for 48 hour period including 
## 2007-02-01 and 2007-02-02
## Timestamps are complete, and began 2006-12-16 at 17:24 hh:mm
##


## > difftime("2007-02-01 00:00:00", "2006-12-16 17:24:00", units = "mins")
## Time difference of 66636 mins
## > difftime("2007-02-02 24:00:00", "2006-12-16 17:24:00", units = "mins")
## Time difference of 69516 mins
##
## > 69516 - 66636 [1] 2880


##
## So we skip 66636 rows, and use a maximum of 2880
## skip = 66636, nrows = 2880
##

power_table <- read.table("~/R/household_power_consumption.txt", 
                          sep = ";", na.strings = "?", 
                          colClasses = c(rep(2, "character"), rep(7, "numeric"))
                          skip = 66636, nrows = 2880)


header <- read.table("~/R/household_power_consumption.txt", 
                     sep = ";", na.strings = "?", header = TRUE, nrows = 1)
##
## Gives a small table we can then read the colnames from

colnames(power_table) <- colnames(header)
##
## Concatenate $Date and $Time as $DateTime and then into POSIXct using strptime()
##
power_table$DateTime <- paste(power_table$Date, power_table$Time, sep = " ")
power_table$DateTime <- strptime(power_table$DateTime, "%d/%m/%Y %H:%M:%S")


## Produce Histograms for Plot #1:

png(filename = "plot1.png")
## Initialize a png graphics device.


hist(power_table$Global_active_power, 
     freq = TRUE, 
     
     ## freq = TRUE, plots frequencies of global active power levels,
     ## Power levels are binned by the default "Sturges" algorithm (breaks = "Sturges")
     
     col = 2, 
     
     ## col = 2 gives a red fill for each histogram bar
     
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

## Title specified by, "main = 'Global Active Power' "
## x-axis labeled similarly using "xlab" argument.

dev.off()
## Close the png graphics device.
