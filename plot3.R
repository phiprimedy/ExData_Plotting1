# Load data from the supplied file
data_raw <- read.table(file="../household_power_consumption.txt", 
                       header=TRUE,
                       sep = ";", 
                       na.strings="?", 
                       stringsAsFactors = FALSE)

# Convert only the Date as we need only that for subsetting to
# get the rows for the 2 days that we need for the plots
data_raw$Date <- as.Date(data_raw$Date, "%d/%m/%Y")


# Subset the loaded data to incude only those rows that are for 
# 01/02/2007 q=and 02/02/2007
startDate <- as.Date("01/02/2007", "%d/%m/%Y" ) 
endDate <- as.Date( "02/02/2007", "%d/%m/%Y")
data <- subset(data_raw, Date %in% c(startDate,endDate) )


# Now that we have selected our subset, we include both date and time 
# in the Date field as plots will need to use datetime. The Time field
# stays on as a character field but we don't use it separately.
data$Date <- 
  strptime(
           paste(strftime(data$Date, "%d/%m/%Y"),data$Time, sep=" "), 
           "%d/%m/%Y %H:%M:%S"
           )

# Plot 3
png("plot3.png")
plot(data$Date,
     data$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering",
     col="black")
lines(data$Date,
      data$Sub_metering_2,
      col="red")
lines(data$Date,
      data$Sub_metering_3,
      col="blue")
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lty=1, col=c('black', 'red', 'blue'))
dev.off()