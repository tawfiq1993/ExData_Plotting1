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

##plot1 code

hist(Finaldata$Global_active_power, col = "Red", breaks = 20 , 
     xlab = "Global Active Power", main = "Global Active Power")

dev.copy(png, "plot1.png", width =480 , height = 480)

dev.off()


