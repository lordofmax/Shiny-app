

uscounties <- read.csv("uscities.csv")
unemployment_rate <- read.csv("GeoFRED_Unemployment_Rate_by_County_Percent.csv")

#df3 = merge(df1, df2, by.x=c("CustomerId", "Hobby"), by.y=c("CustomerId", "like"))

updated_column = uscounties$county_name <- paste(uscounties$county_name, "County,", uscounties$state_id)
updated_column

uscounties <- uscounties[ -c(6,8)]


uscounties[6] = updated_column
names(uscounties)[6] <- "Region_Name"

#uscounties = distinct(uscounties)
#uscounties

#deduped.data <- unique( yourdata[ , 1:3 ] )
library(dplyr)
library(tidyr)
uscounties1 <- uscounties

# Remove duplicate rows of the dataframe using carb variable
uscounties2 = distinct(uscounties1,Region_Name, .keep_all= TRUE)

names(unemployment_rate)[2] <- "Region_Name"
unemployment_rate


New_df = merge(x = unemployment_rate, y = uscounties2, by="Region_Name", all.x = TRUE)
New_df1 = New_df %>% drop_na()

final_output = select(New_df1, "Region_Name", "state_name","lat","lng","population","density",
                     "2000"="X2000",'2001' = "X2001","2002"="X2002","2003"="X2003","2004"="X2004",
                     "2005"="X2005","2006"="X2006","2007"="X2007","2008"="X2008","2009"="X2009",
                     "2010"="X2010","2011"="X2011","2012"="X2012","2013"="X2013","2014"="X2014",
                     "2015"="X2015","2016"="X2016","2017"="X2017","2018"="X2018")

#final_output1 = names(final_output)[7:25] <- c(2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018)

# Write CSV in R
write.csv(final_output, file = "US_unemployment_rate.csv")


library(leaflet)
library(readr)
point_data <- read_csv("http://environmentalcomputing.net/wp-content/uploads/2018/03/point_data.csv")

leaflet(point_data) %>% 
  fitBounds(lng1 = min(point_data$lon) - 0.11, 
            lat1 = min(point_data$lat) - 0.11,
            lng2 = max(point_data$lon) + 0.11, 
            lat2 = max(point_data$lat) + 0.11) %>% 
  addCircleMarkers(~lon, ~lat,
                   radius = 3,
                   opacity = 100,
                   color = "white", 
                   label = as.character(point_data$Site), 
                   labelOptions = labelOptions(noHide = TRUE, 
                                               textOnly = TRUE, 
                                               style = list(color = "white"),
                                               direction = "auto",
                                               offset = c(0, -10))) %>% 
  addScaleBar(options = list(imperial = FALSE)) %>%
  addProviderTiles(providers$Esri.WorldImagery)