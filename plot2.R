# Read PM2.5 Emission data
NEI <- readRDS("summarySCC_PM25.rds")

# Read Source Classification Codes (SCC)  data
SCC <- readRDS("Source_Classification_Code.rds")

# Filter Data for Baltimore City (fips = 24510)
NEI_BALTIMORE <- subset(NEI, fips == "24510")

# Aggregate by Year
# First column in the Aggregate is named Year
# Second (Total Emissions) column is named x by default

NEI_BALTIMORE_YEAR <- aggregate(NEI_BALTIMORE$Emissions,by=list(Year=NEI_BALTIMORE$year),sum)


# Plot the total emissions by year
plot (NEI_BALTIMORE_YEAR$Year,NEI_BALTIMORE_YEAR$x, xlab="YEAR", ylab="PPM2.5", pch=20)
fit <- lm (NEI_BALTIMORE_YEAR$x ~ NEI_BALTIMORE_YEAR$Year)
abline(fit) 
title("Total Emissions in Baltimore, US")
legend("topright",legend="PPM2.5 in Tonnes", cex=0.8, pch=20)

##Copy plot to file 
dev.copy(png,filename="plot2.png");
dev.off ();