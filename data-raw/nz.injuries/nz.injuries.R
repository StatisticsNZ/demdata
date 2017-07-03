
library(methods)
library(dplyr)

path <- file.path("data-raw",
                  "nz.injuries",
                  "Count_of_fatal_and_series_non-fatal_injuries_by_sex",
                  "TABLECODE7935_Data_32d81df2-590c-443e-bc4e-7030037f2be2.csv") 

nz.injuries <- read.csv(path) %>%
    select(year = Year, age = "Age.group", cause = "Cause.of.injury", sex = Sex, count = "Value")

save(nz.injuries,
     file = "data/nz.injuries.rda",
     compress = "xz")
