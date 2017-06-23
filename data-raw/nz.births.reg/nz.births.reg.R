
library(readr)
library(dplyr)

nz.births.reg <- read_csv("data-raw/nz.births.reg/rc13_bths9716_rr3.csv")
nz.births.reg <- nz.births.reg %>%
    mutate(age = substr(age_grp_mother, start = 1, stop = 2),
           age = as.integer(age),
           age = paste(age, age + 4, sep = "-")) %>%
    mutate(region = gsub(" Region", "", rc13desc),
           region = recode(region, "Area Outside" = "Area Outside Region"),
           region = factor(region, levels = unique(region)))
nz.births.reg <- xtabs(count ~ age + sex + region + year,
                       data = nz.births.reg)
nz.births.reg <- array(nz.births.reg,
                       dim = dim(nz.births.reg),
                       dimnames = dimnames(nz.births.reg))
save(nz.births.reg,
     file = "data/nz.births.reg.rda",
     compress = "xz")
