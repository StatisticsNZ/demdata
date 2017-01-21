#!/usr/local/bin/Rscript

library(methods)
library(tidyr)
library(plyr)

d <- read.csv("data-raw/iceland.migrants/MAN01401-3.csv",
              skip = 2)
d <- gather(d, key, value, -Sex, -Year, -Age)
d$key <- sub("citizens\\.", "", d$key)
d <- extract(d, key, c("citizenship", "direction"), "(.+)\\.(.+)")
names(d) <- tolower(names(d))
d$age <- sub("Under 1 year", "0", d$age)
d$age <- sub(" year$| years$", "", d$age)
d$age <- as.integer(d$age)
d$age <- factor(d$age,
                levels = seq.int(from = 0, to = max(d$age)))
iceland.migrants <- xtabs(value ~ age + sex + year + citizenship + direction,
                          data = d)
iceland.migrants <- array(as.integer(iceland.migrants),
                          dim = dim(iceland.migrants),
                          dimnames = dimnames(iceland.migrants))
save(iceland.migrants,
     file = "data/iceland.migrants.rda",
     compress = "bzip2")
