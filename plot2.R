## Read file
df <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")

## Generate running datetime column to be used in the x axis
df$datetime <- as.POSIXct(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")

## Filter the wanted date range
df <- with(df, df[(datetime >= "2007-02-01" & datetime < "2007-02-03"), ])

par(bg = NA)
png(file = "plot2.png", width = 480, height = 480)
with(df, plot(datetime, Global_active_power, type="l", main="", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()