# Load data from file
library(data.table)
dt <- fread('../household_power_consumption.txt',header=T,sep=';')

# Select relevant rows
takeThese <- dt$Date=="1/2/2007" | dt$Date=="2/2/2007"
dt <- dt[takeThese,]

# Create first plot
x <- as.numeric(dt$Global_active_power)
x <- x[!is.na(x)]
xticks <- seq(0,6,by=2)
par(pty="s",ps=12,mfrow=c(1,1))
hist(x,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power",xlim=c(0,6),ylim=c(0,1200),xaxt="n")
axis(1,at=xticks)
dev.copy(png,file="plot1.png")
dev.off()