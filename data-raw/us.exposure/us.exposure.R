
library(readr)
library(dplyr)
library(tidyr)

us.exposure <- read.table("data-raw/US data from HMD/Exposures_1x1.txt",
                        skip = 2,
                        header = TRUE) %>%
    select(-Total) %>%
    rename(year = Year, age = Age) %>%
    gather(key = "sex", value = "count", Female, Male) %>%
    mutate(age = factor(age, levels = c(0:109, "110+"))) %>%
    mutate(count = as.integer(count)) %>%
    xtabs(count ~ age + sex + year, data = .) %>%
    array(., dim = dim(.), dimnames = dimnames(.))

save(us.exposure,
     file = "data/us.exposure.rda",
     compress = "xz")


