
afghan.life <- read.csv("data-raw/WPP2015_DB05_Life_Table.csv")
afghan.life <- subset(afghan.life,
                      subset = ((Location == "Afghanistan")
                          & Sex != "Both"))
afghan.life$age <- factor(afghan.life$AgeGrpStart,
                          levels = c(0, 1, seq(5, 85, 5)),
                          labels = c("0",
                                     "1-4",
                                     paste(seq(5, 80, 5), seq(9, 84, 5), sep = "-"),
                                     "85+"))
afghan.life$time <- factor(afghan.life$Time,
                           levels = paste(seq(1950, 2095, 5), seq(1955, 2100, 5), sep = "-"),
                           labels = paste(seq(1951, 2096, 5), seq(1955, 2100, 5), sep = "-"))
afghan.life$sex <- factor(afghan.life$Sex, levels = c("Female", "Male"))
afghan.life$qx[is.na(afghan.life$qx)] <- 1
afghan.life$px[is.na(afghan.life$px)] <- 0
fun <- c("mx", "qx", "px", "lx", "dx", "Lx", "Sx", "Tx", "ex", "ax")
afghan.life <- reshape(afghan.life,
                       varying = list(fun),
                       v.names = "value",
                       timevar = "fun",
                       times = fun,
                       idvar = c("age", "sex", "time"),
                       drop = c("LocID", "Location", "VarID", "Variant", "Time", "MidPeriod",
                                "SexID", "Sex", "AgeGrpStart", "AgeGrpSpan"),
                       direction = "long")
afghan.life$fun <- factor(afghan.life$fun,
                          levels = fun)
afghan.life <- xtabs(value ~ age + sex + time + fun,
                     data = afghan.life)
afghan.life <- array(as.numeric(afghan.life),
                     dim = dim(afghan.life),
                     dimnames = dimnames(afghan.life))
save(afghan.life,
     file = "data/afghan.life.rda",
     compress = "xz")
