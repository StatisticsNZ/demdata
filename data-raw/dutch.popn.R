
dutch.popn <- read.csv("data-raw/POP_PROJ_04062016225548685.csv")
dutch.popn <- subset(dutch.popn,
                       select = c(Age, Sex, Time, Value))
colnames(dutch.popn) <- c("age", "sex", "time", "value")
rownames(dutch.popn) <- NULL
dutch.popn$age <- sub("Population (hist&proj)  ", "", dutch.popn$age, fixed = TRUE)
dutch.popn$age <- factor(dutch.popn$age,
                         levels = c(paste(sprintf("%02.0f", seq(0, 80, 5)),
                             sprintf("%02.0f", seq(4, 84, 5)),
                             sep = "-"),
                             "85+ "),
                         labels = c(paste(seq(0, 80, 5),
                             seq(4, 84, 5),
                             sep = "-"),
                             "85+"))
dutch.popn <- xtabs(value ~ age + sex + time,
                    data = dutch.popn)
dutch.popn <- array(dutch.popn,
                    dim = dim(dutch.popn),
                    dimnames = dimnames(dutch.popn))
save(dutch.popn,
     file = "data/dutch.popn.rda",
     compress = "xz")

