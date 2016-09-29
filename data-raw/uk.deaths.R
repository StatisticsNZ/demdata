

uk.deaths <- read.csv("data-raw/HMD_UK_deaths/Deaths_1x1.txt",
                      skip = 3,
                      as.is = TRUE,
                      header = FALSE)
uk.deaths <- strsplit(uk.deaths[[1]], split = " +")
uk.deaths <- data.frame(year = sapply(uk.deaths, function(x) x[1]),
                        age = sapply(uk.deaths, function(x) x[2]),
                        female = sapply(uk.deaths, function(x) x[3]),
                        male = sapply(uk.deaths, function(x) x[4]))
uk.deaths <- reshape(uk.deaths,
                     varying = list(c("female", "male")),
                     v.name = "value",
                     timevar = "sex",
                     times = c("Female", "Male"),
                     idvar = c("year", "age"),
                     direction = "long")
uk.deaths$age <- factor(uk.deaths$age, levels = c(0:109, "110+"))
uk.deaths$year <- as.integer(levels(uk.deaths$year))[uk.deaths$year]
uk.deaths$value <- as.numeric(levels(uk.deaths$value))[uk.deaths$value]
uk.deaths$value <- round(uk.deaths$value)
uk.deaths$value <- as.integer(uk.deaths$value)
uk.deaths <- xtabs(value ~ age + sex + year, data = uk.deaths)
uk.deaths <- array(as.integer(uk.deaths),
                   dim = dim(uk.deaths),
                   dimnames = dimnames(uk.deaths))


uk.exposure <- read.csv("data-raw/HMD_UK_deaths/Exposures_1x1.txt",
                        skip = 2,
                        as.is = TRUE,
                        header = TRUE)
uk.exposure <- strsplit(uk.exposure[[1]], split = " +")
uk.exposure <- data.frame(year = sapply(uk.exposure, function(x) x[2]),
                          age = sapply(uk.exposure, function(x) x[3]),
                          female = sapply(uk.exposure, function(x) x[4]),
                          male = sapply(uk.exposure, function(x) x[5]))
uk.exposure <- reshape(uk.exposure,
                       varying = list(c("female", "male")),
                       v.name = "value",
                       timevar = "sex",
                       times = c("Female", "Male"),
                       idvar = c("year", "age"),
                       direction = "long")
uk.exposure$age <- factor(uk.exposure$age, levels = c(0:109, "110+"))
uk.exposure$year <- as.integer(levels(uk.exposure$year))[uk.exposure$year]
uk.exposure$value <- as.numeric(levels(uk.exposure$value))[uk.exposure$value]
uk.exposure <- xtabs(value ~ age + sex + year, data = uk.exposure)
uk.exposure <- array(as.numeric(uk.exposure),
                     dim = dim(uk.exposure),
                     dimnames = dimnames(uk.exposure))


save(uk.deaths,
     file = "data/uk.deaths.rda",
     compress = "xz")
save(uk.exposure,
     file = "data/uk.exposure.rda",
     compress = "xz")



