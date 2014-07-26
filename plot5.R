library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter emissions for Balitmore (fips=24510) and Motor Vehicles (Type = On-road)
NEI_BALTIMORE_AUTO <- subset(NEI, fips == "24510" & type == "ON-ROAD")

# Aggregate Baltimore emissions by year
NEI_BALTIMORE_AUTO_TOTAL <- aggregate(NEI_BALTIMORE_AUTO$Emissions,by=list(Year=NEI_BALTIMORE_AUTO$year),sum)

qplot (Year,x, data= NEI_BALTIMORE_AUTO_TOTAL,  
       geom=c("point","smooth"), method="lm", se=FALSE,
       main = "Yearly Emissions trends from Motor Vehicle sources in Baltimore City",
       xlab = "Year", ylab="PM2.5 Emissions in Tonnes"
       )

##Copy plot to file 
dev.copy(png,filename="plot5.png");
dev.off ();