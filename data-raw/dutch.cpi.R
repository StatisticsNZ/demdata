
dutch.cpi <- read.csv("data-raw/KEI_04062016052113516.csv",
                      as.is = TRUE)
dutch.cpi <- subset(dutch.cpi,
                    subset = Frequency == "Annual",
                    select = c(Time, Value))
rownames(dutch.cpi) <- NULL
colnames(dutch.cpi) <- tolower(colnames(dutch.cpi))
dutch.cpi$time <- as.integer(dutch.cpi$time)
save(dutch.cpi, file = "data/dutch.cpi.rda")

