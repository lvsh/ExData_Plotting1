# Load data from file
library(data.table)
dt <- fread('../household_power_consumption.txt',header=T,sep=';')

# Select relevant rows
takeThese <- dt$Date=="1/2/2007" | dt$Date=="2/2/2007"
dt <- dt[takeThese,]

# Convert date and time to appropriate format
t <- strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %H:%M:%S")

# Create third plot
x <- as.numeric(dt$Sub_metering_1)
par(pty="s",ps=12,mfrow=c(1,1))
plot(t,x,ylab="Energy sub metering",xlab="",type="n")
lines(t,x,type="l",col="black")
x <- as.numeric(dt$Sub_metering_2)
lines(t,x,type="l",col="red")
x <- as.numeric(dt$Sub_metering_3)
lines(t,x,type="l",col="blue")

# Getting legend to look right is tricky! It also looks different on screen and in PNG.
l <- legend(x=t[1575],y=41,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),seg.len=0.75,text.width=strwidth("10,000"),x.intersp=0.33,y.intersp=0.33,plot=F)
red_x <- 10000 # reduction in width of default label box
red_y <- 1.5 # reduction in height of default label box
legend(x=t[1575],y=41,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),seg.len=0.75,text.width=strwidth("10,000"),x.intersp=0.33,y.intersp=0.33,bty="n")
rect(xleft=l$rect$left+red_x,xright=l$rect$left+l$rect$w,ybottom=l$rect$top-l$rect$h+red_y,ytop=l$rect$top)

# Copy to PNG
dev.copy(png,file="plot3.png")
dev.off()
