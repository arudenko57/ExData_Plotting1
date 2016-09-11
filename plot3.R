plot3 <- function() {
  ### --------------------------------------------------------
  ### Explore Data Plotting Course - Project Assignment 1
  ### --------------------------------------------------------
  ### This script creates Plot3.png file
  ### --------------------------------------------------------
  
  # Download and unzip the Electric Power Consumption file
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl,destfile = "electric.zip")
  pth <- paste(path.expand(getwd()), "/electric.zip", sep = "")
  unzip(pth)
  # "household_power_consumption.txt" is the unzipped file
  
  # Read file into a data frame
  efile <- read.csv("household_power_consumption.txt",header = TRUE,sep = ";", stringsAsFactors = FALSE)
  # str(efile)
  # 'data.frame':	2075259 obs. of  9 variables:
  #  $ Date                 : chr  "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006" ...
  # $ Time                 : chr  "17:24:00" "17:25:00" "17:26:00" "17:27:00" ...
  # $ Global_active_power  : chr  "4.216" "5.360" "5.374" "5.388" ...
  # $ Global_reactive_power: chr  "0.418" "0.436" "0.498" "0.502" ...
  # $ Voltage              : chr  "234.840" "233.630" "233.290" "233.740" ...
  # $ Global_intensity     : chr  "18.400" "23.000" "23.000" "23.000" ...
  # $ Sub_metering_1       : chr  "0.000" "0.000" "0.000" "0.000" ...
  # $ Sub_metering_2       : chr  "1.000" "1.000" "2.000" "1.000" ...
  # $ Sub_metering_3       : num  17 16 17 17 17 17 17 17 17 16 ...
  
  # Convert "Date" variable from character to "Date" class 
  efile$Date <- as.Date(efile$Date,"%d/%m/%Y")
  # str(efile)
  # 'data.frame':	2075259 obs. of  9 variables:
  #  $ Date                 : Date, format: "2006-12-16" "2006-12-16" ...
  
  # Select data only for 2007/02/01 and 2007/02/02
  subfile <- subset(efile, (Date >= "2007-02-01" & Date <= "2007-02-02"))
  # dim(subfile)
  # 2880    9
  
  # Convert Global_active_power to numeric
  subfile$Global_active_power <- as.numeric(subfile$Global_active_power)
  
  # Add date-time variable to the file
  subfile$DateTime <- as.POSIXct(paste(subfile$Date,subfile$Time))
  
  # Convert to numeric
  subfile$Sub_metering_1 <- as.numeric(subfile$Sub_metering_1)
  subfile$Sub_metering_2 <- as.numeric(subfile$Sub_metering_2)
  
  # plot a blank graph
  plot(x=subfile$DateTime, y=subfile$Sub_metering_1, xlab='', ylab="Energy sub metering", type="n")
  
  # Draw three graphs
  with(subfile,lines(DateTime,Sub_metering_1))
  with(subfile,lines(DateTime,Sub_metering_2,col="red"))
  with(subfile,lines(DateTime,Sub_metering_3,col="blue"))
  
  #Add legend
  legend("topright",pch=c("_","_","_"),col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  # Copy to a png file 
  dev.copy(png, file="plot3.png", height=480, width=480)
  dev.off()
  
}