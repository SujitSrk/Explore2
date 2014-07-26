library(data.table)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_DT <- data.table(NEI)
NEI_YEAR <- NEI_DT[, sum(Emissions), by = year]

# First column is named year, second column V1 
plot (NEI_YEAR$year,NEI_YEAR$V1, xlab="YEAR", ylab="PPM2.5", pch=20)
fit <- lm (NEI_YEAR$V1 ~ NEI_YEAR$year)
abline(fit)
title("Total Emissions in US")
legend("topright",legend="PPM2.5 in Tonnes", pch=20)

### Q2 Baltimore
NEI_B <- subset(NEI_DT, fips == "24510")
NEI_BYEAR <- NEI_B[, sum(Emissions), by = year]
plot (NEI_BYEAR$year,NEI_BYEAR$V1, xlab="YEAR", ylab="PPM2.5", pch=20)
fitB <- lm (NEI_BYEAR$V1 ~ NEI_BYEAR$year)
abline(fitB) 
title("Total Emissions in Baltimore, US")
legend("topright",legend="PPM2.5 in Tonnes", pch=20)

### Q3 for type=POINT repeat for other 3 types
NEI_B_1 <- subset(NEI_B, type=="POINT")
NEI_B_1_YEAR <- NEI_B_1[, sum(Emissions), by = year]
ggplot(NEI_B_1_YEAR, aes(x=year, y=V1)) +
  geom_point(shape=1) +    # Use hollow circles
  geom_smooth(method=lm,se=FALSE)   # Add linear regression line 

#Q4
