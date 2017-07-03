
library(dplyr)

russia.births <- read.csv("data-raw/russia.births/UNdata_Export_20160304_232915853.csv",
                          nrows = 410) %>%
    select(year = Year, sex = Sex, age = Age.of.mother, count = Value) %>%
    mutate(age = recode(age, "50 +" = "50+"))

save(russia.births,
     file = "data/russia.births.rda")


