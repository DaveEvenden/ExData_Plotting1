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

## convert  needed data type
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))

## plot 2 to file
png("plot2.png")
plot(hpc$DateTime, hpc$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab="")
dev.off()

# END 