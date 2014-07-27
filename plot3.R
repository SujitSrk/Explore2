library(ggplot2)

# Read PM2.5 Emission data
NEI <- readRDS("summarySCC_PM25.rds")

# Read Source Classification Codes (SCC)  data
SCC <- readRDS("Source_Classification_Code.rds")


# Filter Data for Baltimore City (fips = 24510)
NEI_BALTIMORE <- subset(NEI, fips == "24510")

# Aggregate by Year and Type
# Total Emissions column is named x by default
NEI_BALTIMORE_YEARTYPE <- aggregate(NEI_BALTIMORE$Emissions,by=list(Year=NEI_BALTIMORE$year, Type=NEI_BALTIMORE$type),sum)

# Plot using ggplot facets - one panel for each type
qplot (Year,x, data= NEI_BALTIMORE_YEARTYPE, facets = .~Type, 
       geom=c("point","smooth"), method="lm",
       main = "Yearly Emission Trends in Baltimore from various types",
       xlab = "Year", ylab="PM2.5 Emission in Tonnes")


##Copy plot to file 
dev.copy(png,filename="plot3.png");
dev.off ();