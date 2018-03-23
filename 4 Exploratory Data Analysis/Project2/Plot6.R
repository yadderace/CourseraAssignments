library(ggplot2);

#Load the data
summary_data <- readRDS("summarySCC_PM25.rds");
source_classification_code <- readRDS("Source_Classification_Code.rds");

#Subsetting combustion and coal data from source clasification code set.
vehicle_scc <- source_classification_code[grepl("vehicle", source_classification_code$SCC.Level.Two, ignore.case = TRUE),];

#Subsetting combustion and coal data from summary data set
vehicle_data <- summary_data[summary_data$SCC %in%  vehicle_scc$SCC ,]

#Subsetting the data from Baltimore City
baltimore_angeles_data <- subset(vehicle_data, fips == "24510" | fips == "06037");

# Sum all the emissions by year.
aggregated_by_year <- aggregate(Emissions ~ year + fips, baltimore_angeles_data, sum);

aggregated_by_year$city <- ifelse(aggregated_by_year$fips == '24510', 'Baltimore City', 'Los Angeles');

#Create the g object
g <- ggplot(aggregated_by_year, aes(x = factor(year),y = Emissions, fill=city))

#Add configuration to the graphic
gg <- g + geom_bar(stat="identity") + 
  facet_grid(.~city) +
  labs(x="Year", y="PM2.5 Emissions (Tons)", title="Total Emissions By Year in Baltimore City and Los Angeles (Vehicle)");

png("Plot6.png", width=500, height=500, bg="white");

print(gg);

dev.off();