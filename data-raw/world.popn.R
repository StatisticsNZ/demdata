
library(wpp2015)
library(dplyr)
library(tidyr)

data(popF)
data(popM)

age.levels <- c(paste(seq(0, 95, 5), seq(4, 99, 5), sep = "-"),
                "100+")

females <- mutate(popF, sex = "Female")
males <- mutate(popM, sex = "Male")

world.popn <- rbind(females, males) %>%
    filter(country == "World") %>%
    select(-country, -country_code) %>%
    gather(key = "time", value = "count", -age, -sex) %>%
    mutate(count = 1000 * count) %>%
    mutate(age = factor(age, levels = age.levels)) %>%
    xtabs(count ~ age + sex + time, data = .) %>%
    array(., dim = dim(.), dimnames = dimnames(.))

save(world.popn,
     file = "data/world.popn.rda",
     compress = "xz")
