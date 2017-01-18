

us.deaths <- read.csv("data-raw/US data from HMD/Deaths_1x1.txt",
                      skip = 2,
                      as.is = TRUE,
                      header = TRUE)
us.deaths <- strsplit(us.deaths[[1]], split = " +")
us.deaths <- data.frame(year = sapply(us.deaths, function(x) x[1]),
                        age = sapply(us.deaths, function(x) x[2]),
                        female = sapply(us.deaths, function(x) x[3]),
                        male = sapply(us.deaths, function(x) x[4]))
us.deaths <- reshape(us.deaths,
                     varying = list(c("female", "male")),
                     v.name = "value",
                     timevar = "sex",
                     times = c("Female", "Male"),
                     idvar = c("year", "age"),
                     direction = "long")
us.deaths$age <- factor(us.deaths$age, levels = c(0:109, "110+"))
us.deaths$year <- as.integer(levels(us.deaths$year))[us.deaths$year]
us.deaths$value <- as.numeric(levels(us.deaths$value))[us.deaths$value]
us.deaths$value <- round(us.deaths$value)
us.deaths$value <- as.integer(us.deaths$value)
us.deaths <- xtabs(value ~ age + sex + year, data = us.deaths)
us.deaths <- array(as.integer(us.deaths),
                   dim = dim(us.deaths),
                   dimnames = dimnames(us.deaths))


us.exposure <- read.csv("data-raw/US data from HMD/Exposures_1x1.txt",
                        skip = 2,
                        as.is = TRUE,
                        header = TRUE)
us.exposure <- strsplit(us.exposure[[1]], split = " +")
us.exposure <- data.frame(year = sapply(us.exposure, function(x) x[2]),
                          age = sapply(us.exposure, function(x) x[3]),
                          female = sapply(us.exposure, function(x) x[4]),
                          male = sapply(us.exposure, function(x) x[5]))
us.exposure <- reshape(us.exposure,
                       varying = list(c("female", "male")),
                       v.name = "value",
                       timevar = "sex",
                       times = c("Female", "Male"),
                       idvar = c("year", "age"),
                       direction = "long")
us.exposure$age <- factor(us.exposure$age, levels = c(0:109, "110+"))
us.exposure$year <- as.integer(levels(us.exposure$year))[us.exposure$year]
us.exposure$value <- as.numeric(levels(us.exposure$value))[us.exposure$value]
us.exposure <- xtabs(value ~ age + sex + year, data = us.exposure)
us.exposure <- array(as.numeric(us.exposure),
                     dim = dim(us.exposure),
                     dimnames = dimnames(us.exposure))


save(us.deaths,
     file = "data/us.deaths.rda",
     compress = "xz")
save(us.exposure,
     file = "data/us.exposure.rda",
     compress = "xz")



