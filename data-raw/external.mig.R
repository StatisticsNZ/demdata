
library(readr)
library(dplyr)

nz.ext.mig.reg <- read_csv("data-raw/nz.ext.mig.reg/rc13_pltmig_9716.zip") %>%
    rename(age = age_grp) %>%
    mutate(region = gsub(" Region", "", rc13desc),
           region = recode(region, "Area Outside" = "Area Outside Region"),
           region = factor(region, levels = unique(region)),
           region = recode(region, "Area outside region/ not stated" = "Area Outside Region / Not Stated"))

nz.ext.mig.reg <- xtabs(count ~ age + sex + region + year + direction,
                       data = nz.ext.mig.reg)
nz.ext.mig.reg <- array(nz.ext.mig.reg,
                       dim = dim(nz.ext.mig.reg),
                       dimnames = dimnames(nz.ext.mig.reg))

save(nz.ext.mig.reg,
     file = "data/nz.ext.mig.reg.rda",
     compress = "xz")
