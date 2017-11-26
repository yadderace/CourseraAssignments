library(ggplot2);

#Load the data
summary_data <- readRDS("summarySCC_PM25.rds");
source_classification_code <- readRDS("Source_Classification_Code.rds");

#Subsetting combustion and coal data from source clasification code set.
combustion_scc <- grepl("comb", source_classification_code$SCC.Level.One, ignore.case = TRUE);
coal_scc <- grepl("coal", source_classification_code$SCC.Level.Four, ignore.case = TRUE)
combustion_coal_scc <- source_classification_code[combustion_scc & coal_scc,]

#Subsetting combustion and coal data from summary data set
combustion_coal_data <- summary_data[summary_data$SCC %in%  combustion_coal_scc$SCC,]

# Sum all the emissions by year.
aggregated_by_year <- aggregate(Emissions ~ year, combustion_coal_data, sum);

#Create the g object
g <- ggplot(aggregated_by_year, aes(x = factor(year),y = Emissions/(10^3), fill=year))

#Add configuration to the graphic
gg <- g + geom_bar(stat="identity") + 
  labs(x="Year", y="PM2.5 Emissions(KTon)", title="Total Emissions By Year in United States (Coal and Combustible)");

png("Plot4.png",width=500,height=500,bg="white");

print(gg);

dev.off();
