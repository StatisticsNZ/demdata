#!/usr/local/bin/Rscript

library(methods)
library(tidyr)
library(plyr)

d <- read.csv("data-raw/iceland.popn/MAN00101.csv",
              skip = 2)
names(d) <- tolower(names(d))
d <- gather(d, year, count, -sex, -age)
d$year <- sub("x", "", d$year)
d$age <- sub("Under 1 year", "0", d$age)
d$age <- sub(" year$| years$", "", d$age)
d$age <- as.integer(d$age)
d$age <- factor(d$age,
                levels = seq.int(from = 0, to = max(d$age)))
iceland.popn <- xtabs(count ~ age + sex + year,
                      data = d)
iceland.popn <- array(as.double(iceland.popn),
                      dim = dim(iceland.popn),
                      dimnames = dimnames(iceland.popn))
save(iceland.popn,
     file = "data/iceland.popn.rda",
     compress = "bzip2")
