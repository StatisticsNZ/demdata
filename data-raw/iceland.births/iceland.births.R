library(methods)
library(tidyr)
library(plyr)

d <- read.csv("data-raw/iceland.births/MAN05101.csv",
              skip = 2)
names(d) <- tolower(names(d))
d <- gather(d, year, count, -unit, -age)
d$year <- sub("x", "", d$year)
d$age <- sub("Under 15 years", "<15", d$age)
d$age <- sub("50 years and older", "50+", d$age)
d$age <- sub(" years$", "", d$age)
iceland.births <- xtabs(count ~ age + year,
                        data = d)
iceland.births <- array(as.integer(iceland.births),
                        dim = dim(iceland.births),
                        dimnames = dimnames(iceland.births))
save(iceland.births,
     file = "data/iceland.births.rda",
     compress = "bzip2")
