plot1 <- function() {
  ### --------------------------------------------------------
  ### Explore Data Plotting Course - Project Assignment 1
  ### --------------------------------------------------------
  ### This script creates Plot1.png file
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
  
  # Set up plotting area
  par(mfrow=c(1,1),font.main=1)
  
  # open png file (new plotting device)
  png(filename = "Rplot1.png", width = 480, height = 480,
      units = "px", pointsize = 12, bg = "white", res = NA,
      restoreConsole = TRUE)
  
  # Create histogram and close the png plotting device
  hist(subfile$Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
  dev.off()
  # RStudioGD 
  # 2 
  
}