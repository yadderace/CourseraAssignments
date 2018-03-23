library(ggplot2);

#Load the data
summary_data <- readRDS("summarySCC_PM25.rds");
source_classification_code <- readRDS("Source_Classification_Code.rds");

#Subsetting the data from Baltimore City
baltimore_data <- subset(summary_data, fips == "24510")

# Sum all the emissions by year.
aggregated_by_year_type <- aggregate(Emissions ~ year + type , baltimore_data, sum);


#Create the g object
g <- ggplot(aggregated_by_year_type, aes(x = factor(year),y = Emissions, fill = type))

#Add configuration to the graphic
gg <- g + geom_bar(stat="identity") + 
  facet_grid(.~type) + 
  labs(x="Year", y="PM2.5 Emissions", title="PM2.5 Emissions by Type in Baltimore City");

png("Plot3.png",width=1000,height=500,bg="white");

print(gg);

dev.off();