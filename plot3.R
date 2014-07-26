library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_BALTIMORE <- subset(NEI, fips == "24510")

NEI_BALTIMORE_YEARTYPE <- aggregate(NEI_BALTIMORE$Emissions,by=list(Year=NEI_BALTIMORE$year, Type=NEI_BALTIMORE$type),sum)

qplot (Year,x, data= NEI_BALTIMORE_YEARTYPE, facets = .~Type, 
       geom=c("point","smooth"), method="lm",
       main = "Yearly Emission Trends in Baltimore from various types",
       xlab = "Year", ylab="PM2.5 Emission in Tonnes")

# to be added - Title & legend

##Copy plot to file 
dev.copy(png,filename="plot3.png");
dev.off ();