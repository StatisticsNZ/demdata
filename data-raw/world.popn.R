
library(wpp2015)
data(popF)
data(popM)
years <- seq(1950, 2015, 5)
females <- popF[popF$country == "World", c("age", years)]
males <- popM[popM$country == "World", c("age", years)]
females <- reshape(females,
                   varying = list(as.character(years)),
                   v.names = "count",
                   timevar = "time",
                   times = years,
                   idvar = "age",
                   direction = "long")
males <- reshape(males,
                 varying = list(as.character(years)),
                 v.names = "count",
                 timevar = "time",
                 times = years,
                 idvar = "age",
                 direction = "long")
females$sex <- "Female"
males$sex <- "Male"
world.popn <- rbind(females, males)
world.popn$age <- factor(world.popn$age,
                         levels = c(paste(seq(0, 95, 5),
                                          seq(4, 99, 5),
                                          sep = "-"),
                                    "100+"))
world.popn <- xtabs(count ~ age + sex + time,
                    data = world.popn)
world.popn <- 1000 * world.popn
world.popn <- array(as.integer(world.popn),
                    dim = dim(world.popn),
                    dimnames = dimnames(world.popn))
save(world.popn, file = "data/world.popn.rda")

