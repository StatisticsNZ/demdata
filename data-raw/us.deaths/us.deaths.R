
library(readr)
library(dplyr)
library(tidyr)


us.deaths <- read.table("data-raw/US data from HMD/Deaths_1x1.txt",
                        skip = 2,
                        header = TRUE) %>%
    select(-Total) %>%
    rename(year = Year, age = Age) %>%
    gather(key = "sex", value = "count", Female, Male) %>%
    mutate(age = factor(age, levels = c(0:109, "110+"))) %>%
    mutate(count = as.integer(count)) %>%
    xtabs(count ~ age + sex + year, data = .) %>%
    array(., dim = dim(.), dimnames = dimnames(.))

save(us.deaths,
     file = "data/us.deaths.rda",
     compress = "xz")


