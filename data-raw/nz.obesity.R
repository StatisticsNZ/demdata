

nz.obesity <- read.csv("data-raw/NZHS/alldata.csv")
nz.obesity$ci <- gsub("\\(|\\)", "", nz.obesity$ci)
l <- strsplit(nz.obesity$ci, split = "-")
nz.obesity$lower <- sapply(l, `[[`, 1)
nz.obesity$upper <- sapply(l, `[[`, 2)
nz.obesity <- nz.obesity[-match("ci", names(nz.obesity))]
for (name in c("mean", "lower", "upper"))
    nz.obesity[[name]] <- as.numeric(nz.obesity[[name]]) / 100
all.years <- seq.int(from = min(nz.obesity$time),
                     to = max(nz.obesity$time))
nz.obesity$time <- factor(nz.obesity$time, levels = all.years)
nz.obesity$se <- with(nz.obesity, upper - mean) / qnorm(0.975)
nz.obesity.mean <- with(nz.obesity, tapply(mean, list(age, time), I))
nz.obesity.se <- with(nz.obesity, tapply(se, list(age, time), I))
names(dimnames(nz.obesity.mean)) <- c("age", "time")
names(dimnames(nz.obesity.se)) <- c("age", "time")
nz.obesity.mean <- array(as.numeric(nz.obesity.mean),
                         dim = dim(nz.obesity.mean),
                         dimnames = dimnames(nz.obesity.mean))
nz.obesity.se <- array(as.numeric(nz.obesity.se),
                       dim = dim(nz.obesity.se),
                       dimnames = dimnames(nz.obesity.se))
save(nz.obesity.mean, file = "data/nz.obesity.mean.rda")
save(nz.obesity.se, file = "data/nz.obesity.se.rda")

