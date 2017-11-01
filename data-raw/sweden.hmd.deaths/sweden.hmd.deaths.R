
library(tidyverse)

sweden.hmd.deaths <- read.table("data-raw/sweden.hmd.deaths/SWE.Deaths_1x1.txt",
                                skip = 2,
                                header = TRUE,
                                na.string = ".") %>%
    select(year = Year, age = Age, Female, Male) %>%
    gather(key = "sex", value = "count", -year, -age) %>%
    mutate(age = factor(age, levels = c(0:99, "100+")),
           count = round(count)) %>%
    xtabs(count ~ age + sex + year, data = .) %>%
    array(., dim = dim(.), dimnames = dimnames(.))

save(sweden.hmd.deaths,
     file = "data/sweden.hmd.deaths.rda")
    
