
library(readr)
library(dplyr)

nz.int.mig.reg <- read_csv("data-raw/nz.int.mig.reg/migr_transitions_rc13_9613_rr3.zip",
                           na = "..C")

nz.int.mig.reg <- nz.int.mig.reg %>%
    mutate(age = substr(age_grp, start = 1, stop = 2),
           age = as.integer(age),
           age = ifelse(age < 90, paste(age, age + 4, sep = "-"), "90+")) %>%
    mutate(region_dest = gsub(" Region", "", rc13desc),
           region_dest = recode(region_dest , "Area Outside" = "Area Outside Region"),
           region_dest = factor(region_dest, levels = unique(region_dest))) %>%
    mutate(region_orig = gsub(" Region", "", ur5_rc13desc),
           region_orig = recode(region_orig , "Area Outside" = "Area Outside Region"),
           region_orig = factor(region_orig, levels = levels(region_dest))) %>%
    rename(year = census_year) %>%
    mutate(count = as.integer(count))
    
nz.int.mig.reg <- xtabs(count ~ age + sex + region_orig + region_dest + year,
                       data = nz.int.mig.reg)
nz.int.mig.reg <- array(nz.int.mig.reg,
                       dim = dim(nz.int.mig.reg),
                       dimnames = dimnames(nz.int.mig.reg))

save(nz.int.mig.reg,
     file = "data/nz.int.mig.reg.rda",
     compress = "xz")
