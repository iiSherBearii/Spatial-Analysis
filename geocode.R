#####################
# GEOCODING SCRIPT  #
#By Sheridamae Gudez#
#####################

#####Libraries########
rm(list=ls())
libraries <- c("tidyverse", "tidycensus", "tidygeocoder","sf", "tigris", "tmap", 
               "rmapshaper", "sp", "spdep", "spatstat", "readxl", 
               "GGally", "Hmisc", "ggplot2", "MASS", "VIM", "readr", "openxlsx", "olsrr", 
               "margins", "prediction", "webuse", "sjPlot", "coefplot", "corrplot",
               "spatialreg", "spdep", "knitr", "stargazer", "broom", "glmmfields", 
               "arm", "dotwhisker", "jtools", "sandwich", "mgcv", "rgdal", "gtsummary", 
               "gapminder", "writexl", "psych", "GPArotation", "gridExtra", "glmmTMB",
               "shinyjs", "QuantPsyc", "reghelper", "geosphere")

for (i in libraries){
  tryCatch(library(i, character.only = TRUE),
           print(paste(i, "installed")),
           error = function(e) {install.packages(i);
             library(i, character.only = TRUE)}
  )
  print(paste(i, "loaded"))
}

census_api_key("40c2165602cdba501a3cb01d4b8962a6655cbc2f")
options(tigris_class = "sf")
options(tidygeocoder.progress_bar = TRUE)

#####Import Addresses Dataframe########
addresses <- read_csv('df.csv')

#####Single Address Geocode########
osm_result <- geo(street= "720 E San Ysidro Blvd", city="San Diego", county = "San Diego", state = "California", country = "US",
    method = 'osm')

######Batch Geocoding########
addresses_geocoded <- addresses %>%
  geocode(street = street,
          city = city,
          #state = state,
          #country= country,
          #postalcode = zipcode,
          method="osm",
          full_results=F, #set results to TRUE for full geography, set to FALSE for only lat & long
          progress_bar=TRUE)

#######Save Geocoded Data########
addresses_geocoded <- as.data.frame(addresses_geocoded) %>%
  select(-boundingbox)
write.csv(addresses_geocoded, "addresses_geocoded.csv")
   

