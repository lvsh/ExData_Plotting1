# Load data from file
library(data.table)
dt <- fread('../household_power_consumption.txt',header=T,sep=';')

# Select relevant rows
takeThese <- dt$Date=="1/2/2007" | dt$Date=="2/2/2007"
dt <- dt[takeThese,]

# Convert date and time to appropriate format
t <- strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %H:%M:%S")

# Start creating plots
par(pty="m",ps=12,mfrow=c(2,2))

# Subplot 1
x <- as.numeric(dt$Global_active_power)
plot(t,x,ylab="Global Active Power",xlab="",type="l")

# Subplot 2
x <- as.numeric(dt$Voltage)
plot(t,x,ylab="Voltage",xlab="datetime",type="l")

# Subplot 3 
x <- as.numeric(dt$Sub_metering_1)
plot(t,x,ylab="Energy sub metering",xlab="",type="n")
lines(t,x,type="l",col="black")
x <- as.numeric(dt$Sub_metering_2)
lines(t,x,type="l",col="red")
x <- as.numeric(dt$Sub_metering_3)
lines(t,x,type="l",col="blue")
legend(x=t[840],y=53,lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),seg.len=1.5,y.intersp=0.12,bty="n")

# Subplot 4
x <- as.numeric(dt$Global_reactive_power)
plot(t,x,ylab="Global_reactive_power",xlab="datetime",type="l")

# Copy to PNG
dev.copy(png,file="plot4.png")
dev.off()
