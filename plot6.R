library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore data (fips=24510 ) for On-Road ( implying Motor Vehicle ) emissions
NEI_BALTIMORE_AUTO <- subset(NEI, fips == "24510" & type == "ON-ROAD")
# Aggregate by Year
NEI_BALTIMORE_AUTO_TOTAL <- aggregate(NEI_BALTIMORE_AUTO$Emissions,by=list(Year=NEI_BALTIMORE_AUTO$year),sum)

# Subset LA (fips=06037) data for On-Road ( implying Motor Vehicle ) emissions
NEI_LA_AUTO <- subset(NEI, fips == "06037" & type == "ON-ROAD")
#Aggregate by year
NEI_LA_AUTO_TOTAL <- aggregate(NEI_LA_AUTO$Emissions,by=list(Year=NEI_LA_AUTO$year),sum)

#Plot both data side by side.
ggplot(NEI_BALTIMORE_AUTO_TOTAL, aes(x=Year, y=x)) + 
  #geom_point() + 
  geom_line()  +
  geom_line(data = NEI_LA_AUTO_TOTAL, aes(x=Year, y=x ), colour="RED" )

##Copy plot to file 
dev.copy(png,filename="plot5.png");
dev.off ();