library(ggplot2);

#Load the data
summary_data <- readRDS("summarySCC_PM25.rds");
source_classification_code <- readRDS("Source_Classification_Code.rds");

#Subsetting combustion and coal data from source clasification code set.
vehicle_scc <- source_classification_code[grepl("vehicle", source_classification_code$SCC.Level.Two, ignore.case = TRUE),];

#Subsetting combustion and coal data from summary data set
vehicle_data <- summary_data[summary_data$SCC %in%  vehicle_scc$SCC ,]

#Subsetting the data from Baltimore City
baltimore_data <- subset(vehicle_data, fips == "24510");

# Sum all the emissions by year.
aggregated_by_year <- aggregate(Emissions ~ year, baltimore_data, sum);

#Create the g object
g <- ggplot(aggregated_by_year, aes(x = factor(year),y = Emissions, fill=year))

#Add configuration to the graphic
gg <- g + geom_bar(stat="identity") + 
  labs(x="Year", y="PM2.5 Emissions (Tons)", title="Total Emissions By Year in Baltimore City (Vehicle)");

png("Plot5.png", width=500, height=500, bg="white");

print(gg);

dev.off();
