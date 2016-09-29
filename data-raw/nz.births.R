
kLevelsRegion <- c("Northland",
                   "Auckland",
                   "Waikato",
                   "Bay of Plenty",
                   "Gisborne",
                   "Hawke's Bay",
                   "Taranaki",
                   "Manawatu-Wanganui",
                   "Wellington",
                   "Tasman",
                   "Nelson",
                   "Marlborough",
                   "West Coast",
                   "Canterbury",
                   "Otago",
                   "Southland")
kLevelsAge <- paste(seq(15, 40, 5), seq(19, 44, 5), sep = "-")
nz.births <- read.csv("data-raw/VSB356401_20160609_072305_11.csv",
                      skip = 1,
                      nrows = 96)
nz.births$age <- rep(kLevelsAge, times = length(kLevelsRegion))
nz.births$age <- factor(nz.births$age, levels = kLevelsAge)
nz.births$region <- rep(kLevelsRegion, each = 6)
nz.births$region <- factor(nz.births$region, levels = kLevelsRegion)
nz.births <- reshape(nz.births,
                     varying = list(paste0("X", 1991:2015)),
                     v.names = "count",
                     idvar = c("region", "age"),
                     timevar = "year",
                     times = 1991:2015,
                     direction = "long",
                     drop = c("X", "X.1"))
nz.births <- xtabs(count ~ age + year + region,
                   data = nz.births)
nz.births <- array(nz.births,
                   dim = dim(nz.births),
                   dimnames = dimnames(nz.births))
save(nz.births, file = "data/nz.births.rda")

    
