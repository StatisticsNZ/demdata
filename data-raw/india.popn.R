
india.popn <- read.csv("data-raw/PopulationAgeSex-20151019121341/Data-Table-1.csv",
                       skip = 6,
                       header = FALSE,
                       col.names = c("NULL", "NULL", "NULL", "NULL", "age", "female", "male"),
                       colClasses = c("NULL", "NULL", "NULL", "NULL",
                                     "character", "integer", "integer"))
levels.age <- india.popn$age
india.popn <- reshape(india.popn,
                      varying = list(c("female", "male")),
                      v.name = "count",
                      idvar = "age",
                      timevar = "sex",
                      times = c("Female", "Male"),
                      direction = "long")
india.popn$age <- factor(india.popn$age, levels = levels.age)
india.popn <- xtabs(count ~ age + sex, data = india.popn)
india.popn <- array(as.integer(india.popn),
                    dim = dim(india.popn),
                    dimnames = dimnames(india.popn))
save(india.popn, file = "data/india.popn.rda")
