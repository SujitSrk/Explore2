library(ggplot2)

# Read PM2.5 Emission data
NEI <- readRDS("summarySCC_PM25.rds")

# Read Source Classification Codes (SCC)  data
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore data (fips=24510 ) for On-Road ( implying Motor Vehicle ) emissions
NEI_BALTIMORE_AUTO <- subset(NEI, fips == "24510" & type == "ON-ROAD")
# Aggregate by Year
# Total Emissions column is named x by default
NEI_BALTIMORE_AUTO_TOTAL <- aggregate(NEI_BALTIMORE_AUTO$Emissions,by=list(Year=NEI_BALTIMORE_AUTO$year),sum)

# Subset LA (fips=06037) data for On-Road ( implying Motor Vehicle ) emissions
NEI_LA_AUTO <- subset(NEI, fips == "06037" & type == "ON-ROAD")
#Aggregate by year
# Total Emissions column is named x by default
NEI_LA_AUTO_TOTAL <- aggregate(NEI_LA_AUTO$Emissions,by=list(Year=NEI_LA_AUTO$year),sum)

#Since the two emissions are different absolute numbers, it is better to 
# use the rate of change as a measure of  emission from which city changed "more" 

# Get Rate of Change for LA by taking difference between consecutivt readings
# and dividing by the previous reading 

### For LA
# diff(NEI_LA_AUTO_TOTAL$x)= difference between total LA readings for consecutive years
# NEI_LA_AUTO_TOTAL[-nrow(NEI_LA_AUTO_TOTAL),]$x gives all total yearly emission readings in LA except the last as last value is not used in computing %

 
rateLA <- 100*diff(NEI_LA_AUTO_TOTAL$x)/NEI_LA_AUTO_TOTAL[-nrow(NEI_LA_AUTO_TOTAL),]$x

### Compute the Same  (rate of change) For Baltimore
# diff(NEI_BALTIMORE_AUTO_TOTAL$x)= difference between total Baltimore readings for consecutive years
# NEI_BALTIMORE_AUTO_TOTAL[-nrow(NEI_BALTIMORE_AUTO_TOTAL),]$x gives all total yearly emission readings in Baltimore except the last as last value is not used in computing %

rateBALTIMORE <- 100*diff(NEI_BALTIMORE_AUTO_TOTAL$x)/NEI_BALTIMORE_AUTO_TOTAL[-nrow(NEI_BALTIMORE_AUTO_TOTAL),]$x

yearLA <- (NEI_LA_AUTO_TOTAL[-nrow(NEI_LA_AUTO_TOTAL),]$Year)
yearBALTIMORE <- (NEI_BALTIMORE_AUTO_TOTAL[-nrow(NEI_BALTIMORE_AUTO_TOTAL),]$Year)

#Plot rate of change year over year for both LA and Baltomire side by side 
# and check the lm line. Using baseplot

plot (yearLA, rateLA, xlab="YEAR", ylab="PM2.5 Rate of Change", pch=20,  ylim=c(min(rateLA, rateBALTIMORE), max(rateLA, rateBALTIMORE) ))
fit <- lm (  rateLA ~ yearLA)
abline(fit)
lines(yearBALTIMORE, rateBALTIMORE, type="p", xlab="", ylab="",col="red")
fitB <- lm (  rateBALTIMORE ~ yearBALTIMORE)
abline(fitB, col='red')
legend("topright",  lty=1, col=c("black","red"), cex=0.7, legend=c("LA", "Baltimore" ))


##Copy plot to file 
dev.copy(png,filename="plot5.png");
dev.off ();