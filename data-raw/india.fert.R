
age.levels <- paste(seq(15, 45, 5), seq(19, 49, 5), sep = "-")
india.fert <- read.csv("data-raw/AgeSpecificFertilityRates-20151019124023/Data-Table-1.csv",
                       skip = 6,
                       header = FALSE,
                       nrows = 4,
                       col.names = c("NULL", "NULL", "NULL", "period", paste0("X", age.levels)),
                       colClasses = c("NULL", "NULL", "NULL", "character",
                                     rep("numeric", 7)))
india.fert$period <- as.integer(substr(india.fert$period, start = 1, stop = 4))
india.fert$period <- paste(india.fert$period + 1, india.fert$period + 5, sep = "-")
india.fert <- reshape(india.fert,
                      varying = list(2:8),
                      v.name = "count",
                      idvar = "period",
                      timevar = "age",
                      times = age.levels,
                      direction = "long")
india.fert$age <- factor(india.fert$age, levels = age.levels)
india.fert <- xtabs(count ~ age + period, data = india.fert)
india.fert <- array(as.integer(india.fert),
                    dim = dim(india.fert),
                    dimnames = dimnames(india.fert))
save(india.fert, file = "data/india.fert.rda")
