
getwd()

library(tidyverse)

data_job21 <- read.csv("data/alldata_jofbiogeo.txt", sep="")

colnames(data_job21)
data_job21_s <- data_job21 %>% select(species, eventdate)
data_job21_s$eventdate <- as.Date(data_job21_s$eventdate)
data_job21_s$year <- substr(data_job21_s$eventdate, 1, 4)

sections_subgenera <- read.delim("data/sections_subgenera.txt")

data <- merge.data.frame(data_job21_s, sections_subgenera)

rm(data_job21, data_job21_s)
