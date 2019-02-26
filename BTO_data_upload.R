rm(list=ls())

#install.packages("RSelenium")
library(RSelenium)

#set working directory for where R code and data are
setwd("...")

## import data to upload
BTO_data <- read.csv("BTO_2018.csv")
nrow(BTO_data)
head(BTO_data)

## import functions to interact with BTO webpage 
source("BTO_data_upload_functions.R")

## start remote driver
remDr <- remoteDriver(port = 4445L)
remDr$open()

# open BTO webpage - an image of this will be shown
BTO_webpage()

# log in with username and password
BTO_login(username = "...", password = "...")

# navigate to ringing entry page
BTO_ringing_page()

# start upload of all data - record number will be printed when completed - this doesn't mean it was successful however - see below
BTO_ringing_upload(BTO_data)


### Check whether what has been imported matches the records we tried to import
### Manually log into website, go to 'Explore Data' Menu, chose 'Ringing', then search for the period of ringing, and then select to export all data. This will save a csv to the downloads folder

## import saved file (whatever you've called it)
imported <- read.csv("~/Downloads/BTO_import_2018.csv")

## list of not-imported records
imported_list <- with(imported, paste(ring_no, visit_date, capture_time))
BTO_data_list <- with(BTO_data, paste(Ring_No, Visit_Date, Capture_Time))

## dataframe of not-imported records
BTO_data2 <- BTO_data[!BTO_data_list %in% imported_list,]
paste(BTO_data[!BTO_data_list %in% imported_list, "Ring_No"],collapse=",")
nrow(BTO_data2)

## check still logged on. - otherwise use functions above to log back in
remDr$screenshot(display = TRUE)

## upload missing records
BTO_ringing_upload(BTO_data2)
remDr$screenshot(display = TRUE)

## repeat this process until all are uploaded!!!!


