
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get the codes for the Combustion due to Coal
combCoalSCC <- subset(SCC, grepl("comb",SCC.Level.One, ignore.case = TRUE) & grepl("coal",SCC.Level.Three, ignore.case = TRUE) )
 
#Use the codes for coal combustion to filter emission data
combCoal <- subset( NEI, SCC %in% combCoalSCC$SCC )

#Aggregate emissions for the filtered data by year 
combCoalTotal <- aggregate(combCoal$Emissions,by=list(Year=combCoal$year),sum)

qplot (Year,x, data= combCoalTotal,  geom=c("point","smooth"), 
       method="lm", se=FALSE,
       main = "Yearly Emissions trends from coal combustion-related sources",
       xlab = "Year", ylab="PM2.5 Emissions in Tonnes"
       )

# to be added - Title & legend



##Copy plot to file 
dev.copy(png,filename="plot4.png");
dev.off ();
