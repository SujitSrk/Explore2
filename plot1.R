
# Read PM2.5 Emission data
NEI <- readRDS("summarySCC_PM25.rds")

# Read Source Classification Codes (SCC)  data
SCC <- readRDS("Source_Classification_Code.rds")

#Agrregate emissions by Year
NEI_YEAR <- aggregate(NEI$Emissions,by=list(Year=NEI$year),sum, na.rm=TRUE)

# First column in the Aggregate is named Year
# Second (Total Emissions) column is named x by default 
# Plot the total emissions by year
plot (NEI_YEAR$Year,NEI_YEAR$x, xlab="YEAR", ylab="PPM2.5", pch=20)
fit <- lm (NEI_YEAR$x ~ NEI_YEAR$Year)
abline(fit)
title("Total Emissions in US")
legend("topright",legend="PPM2.5 in Tonnes", pch=20)

##Copy plot to file 
dev.copy(png,filename="plot1.png");
dev.off ();