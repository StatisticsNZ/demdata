
library(tidyverse)

sweden.hmd.exposure <- read.table("data-raw/sweden.hmd.exposure/SWE.Exposures_1x1.txt",
                                skip = 2,
                                header = TRUE,
                                na.string = ".") %>%
    select(year = Year, age = Age, Female, Male) %>%
    gather(key = "sex", value = "count", -year, -age) %>%
    mutate(age = factor(age, levels = c(0:99, "100+"))) %>%
    xtabs(count ~ age + sex + year, data = .) %>%
    array(., dim = dim(.), dimnames = dimnames(.))

save(sweden.hmd.exposure,
     file = "data/sweden.hmd.exposure.rda")
    
