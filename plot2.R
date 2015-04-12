# Load data from file
library(data.table)
dt <- fread('../household_power_consumption.txt',header=T,sep=';')

# Select relevant rows
takeThese <- dt$Date=="1/2/2007" | dt$Date=="2/2/2007"
dt <- dt[takeThese,]

# Convert date and time to appropriate format
t <- strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %H:%M:%S")

# Create second plot
x <- as.numeric(dt$Global_active_power)
x <- x[!is.na(x)]
t <- t[!is.na(x)]
par(pty="s",ps=12,mfrow=c(1,1))
plot(t,x,ylab="Global Active Power (kilowatts)",xlab="",type="l")
dev.copy(png,file="plot2.png")
dev.off()