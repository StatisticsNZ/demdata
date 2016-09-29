
dutch.health <- read.csv("data-raw/EBDAG_24052016055802288.csv")
dutch.health <- subset(dutch.health,
                       subset = Unit == "Million of national currency units",
                       select = c("Diagnostic.Category", "Age.Group", "Year", "Value"))
colnames(dutch.health) <- c("diag", "age", "time", "value")
dutch.health$age <- sub(" years and over", "+", dutch.health$age)
dutch.health$age <- sub(" to ", "-", dutch.health$age)
dutch.health$age <- factor(dutch.health$age,
                           levels = c(0, "1-4", paste(seq(5, 90, 5), seq(9, 94, 5), sep = "-"), "95+"))
dutch.health$diag <- factor(dutch.health$diag,
                            levels = unique(dutch.health$diag))
dutch.health$time <- factor(dutch.health$time,
                            levels = 2003:2011)
dutch.health <- tapply(dutch.health[["value"]], dutch.health[c("age", "diag", "time")], sum)
save(dutch.health, file = "data/dutch.health.rda")

