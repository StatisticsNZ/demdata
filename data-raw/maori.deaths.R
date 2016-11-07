
levels.age <- c(0:99, "100+")
deaths <- read.csv("data-raw/VSD349301_20161024_041615_78.csv",
                   skip = 1,
                   nrow = 202)
deaths$sex <- rep(c("Male", "Female"),
                  each = 101)
deaths$sex <- factor(deaths$sex,
                     levels = c("Female", "Male"))
deaths$age <- rep(levels.age,
                  times = 2)
deaths$age <- factor(deaths$age,
                     levels = levels.age)
deaths <- reshape(deaths,
                  varying = list(paste0("X", 1996:2015)),
                  v.names = "count",
                  idvar = c("age", "sex"),
                  timevar = "year",
                  times = 1996:2015,
                  direction = "long",
                  drop = c("X", "X.1"))
deaths <- xtabs(count ~ age + sex + year,
                data = deaths)
maori.deaths <- array(as.integer(deaths),
                      dim = dim(deaths),
                      dimnames = dimnames(deaths))
save(maori.deaths,
     file = "data/maori.deaths.rda")
