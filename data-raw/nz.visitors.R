
levels.age <- c(paste(seq(0, 70, 5), seq(4, 74, 5), sep = "-"), "75+")
countries <-  c(Australia = "Australia",
                China = "China..People.s.Republic.of",
                Japan = "Japan",
                Korea = "Korea..Republic.of",
                Germany = "Germany",
                UK = "United.Kingdom",
                Canada = "Canada",
                USA = "United.States.of.America")
nz.visitors <- read.csv("data-raw/ITM336402_20160907_090956_12.csv",
                        skip = 2,
                        as.is = TRUE,
                        nrow = 4896)
levels.time <- unique(nz.visitors$X)
levels.time <- levels.time[levels.time != " "]
nz.visitors$time <- rep(levels.time, each = 2 * length(levels.age))
nz.visitors$age <- rep(levels.age, each = 2)
nz.visitors$age <- factor(nz.visitors$age,
                          levels = levels.age)
nz.visitors$sex <- factor(nz.visitors$X.2,
                          levels = c("Female", "Male"))
nz.visitors <- reshape(nz.visitors,
                       varying = list(countries),
                       v.names = "count",
                       idvar = c("age", "sex", "time"),
                       timevar = "country",
                       times = names(countries),
                       direction = "long",
                       drop = c("X", "X.1", "X.2"))
nz.visitors <- xtabs(count ~ age + sex + country + time,
                     data = nz.visitors)
nz.visitors <- array(as.integer(nz.visitors),
                     dim = dim(nz.visitors),
                     dimnames = dimnames(nz.visitors))
save(nz.visitors,
     file = "data/nz.visitors.rda",
     compress = "xz")
