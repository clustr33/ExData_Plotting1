## Read file
df <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")

## Generate running datetime column to be used in the x axis
df$datetime <- as.POSIXct(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")

## Filter the wanted date range
df <- with(df, df[(datetime >= "2007-02-01" & datetime < "2007-02-03"), ])

par(bg = NA)
png(file = "plot4.png", width = 480, height = 480)

## Grid of 2x2 plots
par(mfrow = c(2,2))

## Plot 4.1
with(df, plot(datetime, Global_active_power, type="l", main="", xlab="", ylab="Global Active Power"))

## Plot 4.2
with(df, plot(datetime, Voltage, type="l", main="", ylab="Voltage"))

## Plot 4.3
## 1. Create vector of Sub_metering_X names
## 2. Create vector of colors
series_names <- colnames(df)[grep("Sub_met", colnames(df))]
colors <- c("Black", "Red", "Blue")

## Plot the first column
plot(df$datetime, df[[series_names[1]]], type="l", ylab="Energy sub metering", xlab="", col=colors[1])
## Loop through the rest Sub_metering_X columns and add lines for each series
for (i in 2:length(series_names)) {
  lines(df$datetime, df[[series_names[i]]], col=colors[i])
}
## Generate legend from the series names and colors
legend("topright", col=colors, legend=series_names, lty=1, bty="n")

## Plot 4.4
with(df,  plot(datetime, Global_reactive_power, type="l", xlab="datetime"))

dev.off()