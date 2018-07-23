##Reading the file
##Setting na.strings = "?" to read the "?" as NA values
##Setting seperator as ";" 

file <-read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                  na.strings = "?")

##Formatting the Dataset as per required information

file$Date <- as.Date(file$Date, format = "%d/%m/%Y")

Subset_data <- file[c(file$Date == "2007-02-1" | file$Date =="2007-02-02"), ]

Subset_data2 <- mutate(Subset_data, DateTime = paste(Subset_data$Date, 
                                                     Subset_data$Time))

Finaldata <- Subset_data2[,c(10,3:9)]

##Formatting Datetime using lubridate package

Finaldata$DateTime <- ymd_hms(Finaldata$DateTime) 

##plot4 code

par(mfcol = c(2,2))

with(Finaldata, plot(DateTime, Global_active_power, type="l", xlab="",
                     ylab="Global Active Power (kilowatts)"))


with(Finaldata, plot(DateTime, Sub_metering_1, type="l", xlab="", 
                     ylab ="Energy"))
lines(Finaldata$DateTime, Finaldata$Sub_metering_2,col = "Red")
lines(Finaldata$DateTime, Finaldata$Sub_metering_3,col = "blue")
legend("topright", pch = "__", col = c("black", "Red", "orange"), 
       c("Sub_Metering 1", "Sub_Metering 2", "Sub_Metering 3"), cex = 0.75, 
       pt.cex = 1)


with(Finaldata, plot(DateTime, Voltage, type="l", xlab="DateTime",
                     ylab="Voltage"))

with(Finaldata, plot(DateTime, Global_reactive_power, type="l", xlab="",
                     ylab="Global reactive Power"))

dev.copy(png, "plot4.png", width =480 , height = 480)

dev.off()


