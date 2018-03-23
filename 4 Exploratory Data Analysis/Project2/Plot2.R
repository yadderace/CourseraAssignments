#Load the data
summary_data <- readRDS("summarySCC_PM25.rds");
source_classification_code <- readRDS("Source_Classification_Code.rds");

#Subsetting the data from Baltimore City
baltimore_data <- subset(summary_data, fips == "24510");

# Sum all the emissions by year.
aggregated_by_year <- aggregate(Emissions ~ year, baltimore_data, sum);

png("Plot2.png",width=500,height=500,bg="white");

#Plotting aggregated data
with(aggregated_by_year, 
     barplot(
       Emissions, 
       names.arg = year, 
       xlab = "Year", 
       ylab = "PM2.5 Emissions", 
       main = "Total Emissions By Year (Baltimore City)",
       col = topo.colors(4)
     ));

dev.off();