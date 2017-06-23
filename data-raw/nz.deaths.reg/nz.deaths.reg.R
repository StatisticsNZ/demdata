
library(readr)
library(dplyr)

nz.deaths.reg <- read_csv("data-raw/nz.deaths.reg/rc13_dths9716_rr3.csv")

nz.deaths.reg <- nz.deaths.reg %>%
    mutate(age = substr(age_grp, start = 1, stop = 2),
           age = as.integer(age),
           age = paste(age, age + 4, sep = "-")) %>%
    mutate(region = gsub(" Region", "", rc13desc),
           region = recode(region, "Area Outside" = "Area Outside Region"),
           region = factor(region, levels = unique(region)))
nz.deaths.reg <- xtabs(count ~ age + sex + region + year,
                       data = nz.deaths.reg)
nz.deaths.reg <- array(nz.deaths.reg,
                       dim = dim(nz.deaths.reg),
                       dimnames = dimnames(nz.deaths.reg))

save(nz.deaths.reg,
     file = "data/nz.deaths.reg.rda",
     compress = "xz")
