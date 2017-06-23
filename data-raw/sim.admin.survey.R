
## Simulated survey of 5% of the population

set.seed(0)

p.survey <- 0.05

load("data/sim.popn.true.rda")

sim.popn.true.5 <- sim.popn.true[ , , , c("2000", "2010")]
n <- length(sim.popn.true.5)
sim.admin.survey <- rbinom(n = n, size = sim.popn.true.5, prob = p.survey)
sim.admin.survey <- array(sim.admin.survey,
                          dim = dim(sim.popn.true.5),
                          dimnames = dimnames(sim.popn.true.5))

save(sim.admin.survey,
     file = "data/sim.admin.survey.rda",
     compress = "xz")
