
## Accurate data for 'school ages', taken to be 5-14.
## Generated using Poisson-binomial mixture.

set.seed(0)

load("data/sim.popn.true.rda")

school.expected <- sim.popn.true[, c("5-9", "10-14"), , ]
p <- 0.96
n <- length(school.expected)
correctly.counted <- rbinom(n = n, size = school.expected, prob = p)
overcount <- rpois(n = n, lambda = (1 - p) * school.expected)
sim.admin.school <- array(correctly.counted + overcount,
                          dim = dim(school.expected),
                          dimnames = dimnames(school.expected))

save("sim.admin.school",
     file = "data/sim.admin.school.rda",
     compress = "xz")
