#Load the data
summary_data <- readRDS("summarySCC_PM25.rds");
source_classification_code <- readRDS("Source_Classification_Code.rds");

# Sum all the emissions by year.
aggregated_by_year <- aggregate(Emissions ~ year, summary_data, sum);

png("Plot1.png",width=500,height=500,bg="white");

#Plotting aggregated data
with(aggregated_by_year, 
     barplot(
        Emissions/(10^6), 
        names.arg = year, 
        xlab = "Year", 
        ylab = "PM2.5 Emissions (MTons)", 
        main = "Total Emissions By Year",
        col = topo.colors(4)
));

dev.off();
