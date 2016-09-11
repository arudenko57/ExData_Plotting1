plot4 <- function() {
  ### --------------------------------------------------------
  ### Explore Data Plotting Course - Project Assignment 1
  ### --------------------------------------------------------
  ### This script creates Plot4.png file
  ### --------------------------------------------------------
  
  # Download and unzip the Electric Power Consumption file
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl,destfile = "electric.zip")
  pth <- paste(path.expand(getwd()), "/electric.zip", sep = "")
  unzip(pth)
  # "household_power_consumption.txt" is the unzipped file
  
  # Read file into a data frame
  efile <- read.csv("household_power_consumption.txt",header = TRUE,sep = ";", stringsAsFactors = FALSE)

  # Convert "Date" variable from character to "Date" class 
  efile$Date <- as.Date(efile$Date,"%d/%m/%Y")

  # Select data only for 2007/02/01 and 2007/02/02
  subfile <- subset(efile, (Date >= "2007-02-01" & Date <= "2007-02-02"))

  # Convert Global_active_power to numeric
  subfile$Global_active_power <- as.numeric(subfile$Global_active_power)
  
  # Add date-time variable to the file
  subfile$DateTime <- as.POSIXct(paste(subfile$Date,subfile$Time))
  
  # Convert to numeric
  subfile$Sub_metering_1 <- as.numeric(subfile$Sub_metering_1)
  subfile$Sub_metering_2 <- as.numeric(subfile$Sub_metering_2)
  
  # ------------------------------------------------------------------------
  # Prepare for plotting
  # ------------------------------------------------------------------------
  # Divide the drawing area into 2x2
  plot.new()
  par(mfrow = c(2, 2))
  
  # ------------------------------------------------------------------------
  # plot 2
  plot(subfile$Global_active_power ~ subfile$DateTime, ylab="Global Active Power", xlab="", pch=".")
  lines(subfile$DateTime,subfile$Global_active_power)
  
  # ------------------------------------------------------------------------
  
  plot(subfile$Voltage ~ subfile$DateTime, xlab="datetime", ylab="Voltage", pch=".")
  lines(subfile$DateTime,subfile$Voltage)
  
  # ------------------------------------------------------------------------
  # 
  # plot a blank graph
  plot(x=subfile$DateTime, y=subfile$Sub_metering_1, xlab='', ylab="Energy sub metering", type="n")
  
  # Draw three graphs
  with(subfile,lines(DateTime,Sub_metering_1))
  with(subfile,lines(DateTime,Sub_metering_2,col="red"))
  with(subfile,lines(DateTime,Sub_metering_3,col="blue"))
  
  #Add legend
  legend("topright",  
         pch=c("_","_","_"),
         col=c("black","red","blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         cex=0.5)
  
  # ------------------------------------------------------------------------
  plot(subfile$Global_reactive_power ~ subfile$DateTime, xlab="datetime", ylab="Global_reactive_power", pch=".")
  lines(subfile$DateTime, subfile$Global_reactive_power)
  
  # -------------------------------------------------------------------------
  # Copy to a png file 
  dev.copy(png, file="plot4.png", height=480, width=480)
  dev.off()
  
}