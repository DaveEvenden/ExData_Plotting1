## Coursera EDA 7th August 2015
## https://class.coursera.org/exdata-031/human_grading/view/courses/975126/assessments/3/submissions

# Read data from website, download to temp file and unzip
tmp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tmp)
hpc <- read.csv(unz(tmp, "household_power_consumption.txt"), sep=";")
unlink(tmp)
# clean up
rm(tmp)

## convert datatype for the date column 
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

## subset wanted dates 2007-02-01 and 2007-02-02
hpc <- subset(hpc, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## create a new date & time column
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), "%Y-%m-%d %H:%M:%S")

## convert to char to spot ? and replace those with NA
hpc$Sub_metering_1 <- as.character(hpc$Sub_metering_1)
hpc$Sub_metering_1[hpc$Sub_metering_1 == "?"] <- NA
hpc$Sub_metering_2 <- as.character(hpc$Sub_metering_2)
hpc$Sub_metering_2[hpc$Sub_metering_2 == "?"] <- NA

## convert needed data types
hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2)
# hpc$Sub_metering_3 <- as.numeric(hpc$Sub_metering_3) # is not needed

## plot 3 to file
png("plot3.png")
plot (hpc$DateTime, hpc$Sub_metering_1, type = "l", col="black", xlab = "", ylab = "Energy sub metering")
lines(hpc$DateTime, hpc$Sub_metering_2, type = "l", col="red")
lines(hpc$DateTime, hpc$Sub_metering_3, type = "l", col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty=c(1,1,1)) 
dev.off()

# END