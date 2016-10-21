

conc <- read.csv("data-raw/ONS_Deaths/Ward_to_Local_Authority_District_December_2014_Lookup_in_the_United_Kingdom.csv",
                 as.is = TRUE)
conc <- conc[c("LAD14CD", "LAD14NM")]
conc <- unique(conc)
conc <- subset(conc,
               subset = substr(conc$LAD14CD, 1, 1) %in% c("E", "W"))
rownames(conc) <- NULL

age.levels <- c("0", "1_4",
                paste(seq(5, 85, 5), seq(9, 89, 5), sep = "_"),
                "90plus")
col.names <- c("region", "NULL", "NULL",
               paste(c("male", "female"), rep(age.levels, each = 2), sep = "."))

deaths <- read.csv("data-raw/ONS_Deaths/deathsarea2014tcm77431322/Table 2-Table 1.csv",
                   skip = 8,
                   header = FALSE,
                   col.names = col.names,
                   colClasses = c("character", "NULL", "NULL", rep("character", 40)),
                   nrows = 454)
deaths <- subset(deaths, region != "")
deaths$region <- sub("[ ]+$", "", deaths$region)
deaths$region <- sub("‚", ",", deaths$region)
deaths$region[match("Southend on Sea", deaths$region)] <- "Southend-on-Sea"
deaths$region[match("St Helens", deaths$region)] <- "St. Helens"
deaths$region[match("King's Lynn and West Norfolk", deaths$region)] <-
    "Kings Lynn and West Norfolk"
deaths$region[match("Rhondda, Cynon‚ Taff", deaths$region)] <- "Rhondda Cynon Taf"
deaths$region[match("Cornwall and Isles of Scilly2", deaths$region)] <-
    "Cornwall and Isles of Scilly"
regions.keep <- c(conc$LAD14NM,
                  "Cornwall and Isles of Scilly",
                  "Usual residence outside England and Wales")
deaths <- subset(deaths,
                 subset = region %in% regions.keep)
deaths <- reshape(deaths,
                  varying = list(paste("female", age.levels, sep = "."),
                                 paste("male", age.levels, sep = ".")),
                  v.names = c("female", "male"),
                  idvar = "region",
                  timevar = "age",
                  times = age.levels,
                  direction = "long")
deaths <- reshape(deaths,
                  varying = list(c("female", "male")),
                  v.names = "count",
                  idvar = c("region", "age"),
                  timevar = "sex",
                  times = c("Female", "Male"),
                  direction = "long")
deaths$age <- sub("_", "-", deaths$age)
deaths$age <- sub("plus", "+", deaths$age)
rownames(deaths) <- NULL
deaths$count <- sub(",", "", deaths$count)
deaths$count <- as.integer(deaths$count)
deaths$lad <- factor(deaths$region,
                     levels = unique(deaths$region))
stopifnot(identical(sum(deaths$count),
                    245142L + 256282L))

england.wales.deaths <- xtabs(count ~ age + sex + lad,
                              data = deaths)
england.wales.deaths <- array(as.integer(england.wales.deaths),
                              dim = dim(england.wales.deaths),
                              dimnames = dimnames(england.wales.deaths))
save(england.wales.deaths,
     file = "data/england.wales.deaths.rda",
     compress = "xz")



              

