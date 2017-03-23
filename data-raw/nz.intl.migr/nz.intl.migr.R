#!/usr/local/bin/Rscript

library(methods)

removeAdminCrud <- function(x) {
    x <- sub(" \\(to 10\\.2010\\)", "", x)
    x <- sub(" \\(from 11\\.2010\\)", "", x)
    x <- sub("^Area outside territorial authority$", "Area Outside TA", x)
    x <- sub(" district$", "", x)
    x <- sub(" city$", "", x)
    x <- sub(" territory$", "", x)
    x <- sub(" District$", "", x)
    x <- sub(" City$", "", x)
    x <- sub(" Territory$", "", x)
    x <- sub("Not applicable/not stated", "Not stated", x)
    x
}

age.levels <- c(paste(seq(0, 70, 5), seq(4, 74, 5), sep = "-"), "75+")
n.age <- length(age.levels)
sex.levels <- c("Female", "Male")
n.sex <- length(sex.levels)
nz.intl.migr <- read.csv("data-raw/nz.intl.migr/ITM340202_20170305_021409_89.csv",
                         skip = 1,
                         header = TRUE,
                         nrows = 47360)
n.time <- length(unique(nz.intl.migr$X.3))
region.levels <- unique(as.character(nz.intl.migr$X.2))
region.levels <- region.levels[region.levels != " "]
n.region <- length(region.levels)
nz.intl.migr$age <- rep(age.levels, each = n.sex * n.region * n.time)
nz.intl.migr$sex <- rep(rep(sex.levels, each = n.region * n.time), times = n.age)
nz.intl.migr$region <- rep(rep(region.levels, each = n.time), times = n.sex * n.age)
nz.intl.migr$year <- nz.intl.migr$X.3
nz.intl.migr <- reshape(nz.intl.migr,
                        varying = list(c("Arrivals", "Departures")),
                        v.names = "count",
                        idvar = c("age", "sex", "region", "year"),
                        timevar = "direction",
                        times = c("Arrival", "Departure"),
                        drop = c("X", "X.1", "X.2", "X.3"),
                        direction = "long")
rownames(nz.intl.migr) <- NULL

total.check.1 <- xtabs(count ~ year, data = nz.intl.migr)

in.akl <- grepl(" \\(to 10\\.2010\\)", nz.intl.migr$region)
is.akl <- grepl(" \\(from 11\\.2010\\)", nz.intl.migr$region)
akl <- nz.intl.migr[in.akl | is.akl, ]
akl <- aggregate(akl["count"],
                 by = akl[c("age", "sex", "year", "direction")],
                 FUN = sum)
akl$region <- "Auckland (from 11.2010)"
akl$count[akl$year < 2011] <- NA

akl.amalgamated <- nz.intl.migr$year >= 2011
nz.intl.migr$count[in.akl & akl.amalgamated] <- NA
nz.intl.migr <- subset(nz.intl.migr,
                       subset = !is.akl)
nz.intl.migr <- rbind(nz.intl.migr,
                      akl)
region.levels <- unique(as.character(nz.intl.migr$region))
region.levels <- c(setdiff(region.levels, "Auckland (from 11.2010)"),
                   "Auckland (from 11.2010)")
region.levels.short <- removeAdminCrud(region.levels)
region.levels.short[74] <- "Auckland Region"
nz.intl.migr$region <- factor(nz.intl.migr$region,
                              levels = region.levels,
                              labels = region.levels.short)

total.check.2 <- xtabs(count ~ year, data = nz.intl.migr)
stopifnot(identical(total.check.1, total.check.2))

nz.intl.migr$age <- factor(nz.intl.migr$age,
                           levels = age.levels)
nz.intl.migr <- xtabs(count ~ age + sex + region + year,
                      data = nz.intl.migr)
nz.intl.migr <- array(as.integer(nz.intl.migr),
                       dim = dim(nz.intl.migr),
                       dimnames = dimnames(nz.intl.migr))
save(nz.intl.migr,
     file = "data/nz.intl.migr.rda",
     compress = "xz")
