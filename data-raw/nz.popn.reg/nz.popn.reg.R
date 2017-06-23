
library(readr)
library(dplyr)

nz.popn.reg <- read_csv("data-raw/nz.popn.reg/rc13_pop9616_rnd.csv")

nz.popn.reg <- nz.popn.reg %>%
    mutate(age = substr(age_grp, start = 1, stop = 2),
           age = as.integer(age),
           age = ifelse(age < 90, paste(age, age + 4, sep = "-"), "90+")) %>%
    mutate(region = gsub(" Region", "", rc13desc),
           region = recode(region, "Area Outside" = "Area Outside Region"),
           region = factor(region, levels = unique(region)))
nz.popn.reg <- xtabs(count ~ age + sex + region + year,
                     data = nz.popn.reg)
nz.popn.reg <- array(nz.popn.reg,
                     dim = dim(nz.popn.reg),
                     dimnames = dimnames(nz.popn.reg))

save(nz.popn.reg,
     file = "data/nz.popn.reg.rda",
     compress = "xz")
