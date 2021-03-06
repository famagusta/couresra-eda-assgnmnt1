## This script contains the solution for Assignment 1 of
##Coursera course "Exploratory Data Analysis"
## Author: Robin Philip
## email: robinphilip1989[at]gmail[dot]com

setwd("~/Documents/Courses/Data Science/Exploratory Data Analysis/02_Week_1/assgnmnt1/solution/")

############## Download the Data #################

# Download & Extract the data files for further analysis
# run this only the first time
# download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
#              destfile="eda_week1_data.zip", method="curl")
# unzip("eda_week1_data.zip")

#Extracted Filename is "household_power_consumption.txt"



############## Data Clean Up ####################

library("data.table")
hhd_pow_consum_data <- data.table(fread(input="household_power_consumption.txt",
                                        sep=";"))
hhd_pow_consum_data$DATE1 <- as.Date(hhd_pow_consum_data$Date, format="%d/%m/%Y")
hhd_pow_consm_data_feb2012 <- hhd_pow_consum_data[hhd_pow_consum_data$DATE1==as.Date("2007-02-01") | hhd_pow_consum_data$DATE1==as.Date("2007-02-02")]
hhd_pow_consm_data_feb2012$DATE2 <- as.character(strptime(paste(hhd_pow_consm_data_feb2012$Date,
                                                                hhd_pow_consm_data_feb2012$Time),
                                                          format="%d/%m/%Y %H:%M:%S"))



############### Plot 3 ###################
with(hhd_pow_consm_data_feb2012, 
     plot(x = as.POSIXct(DATE2),y=as.numeric(Sub_metering_1),
          type="l", ylab="Energy Sub Metering",xlab="", main=""))
lines(x = as.POSIXct(hhd_pow_consm_data_feb2012$DATE2),
      y=as.numeric(hhd_pow_consm_data_feb2012$Sub_metering_2),col="red")
lines(x = as.POSIXct(hhd_pow_consm_data_feb2012$DATE2),
      y=as.numeric(hhd_pow_consm_data_feb2012$Sub_metering_3),col="blue")
legend("topright",lty= 1, col=c("black", "red", "blue"),
       legend=c("Sub Meter 1", "Sub Meter 2", "Sub Meter 3"))

dev.copy(png, file = "plot3.png",width=480, height=480, units="p") ## Copy my plot to a PNG file
dev.off()



