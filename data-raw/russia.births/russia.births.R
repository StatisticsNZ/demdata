
library(dplyr)

russia.births <- read.csv("data-raw/russia.births/UNdata_Export_20160304_232915853.csv",
                          nrows = 410) %>%
    select(year = Year, sex = Sex, age.of.mother = Age.of.mother, count = Value)

save(russia.births,
     file = "data/russia.births.rda")


