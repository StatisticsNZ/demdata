
## Dataset that is accurate, but only available at national level.
## Generated using Poisson-binomial mixture.

set.seed(0)

load("data/sim.popn.true.rda")

nat.expected <- apply(sim.popn.true, MARGIN = c("age", "sex", "year"), sum)
p <- 0.98
n <- length(nat.expected)
correctly.counted <- rbinom(n = n, size = nat.expected, prob = p)
overcount <- rpois(n = n, lambda = (1 - p) * nat.expected)
sim.admin.nat <- array(correctly.counted + overcount,
                      dim = dim(nat.expected),
                      dimnames = dimnames(nat.expected))

save(sim.admin.nat,
     file = "data/sim.admin.nat.rda",
     compress = "xz")
