
## Simulation-true population data

set.seed(0)

n.region <- 20

load("data/nz.popn.ta.rda")

regions.keep <- sample(dimnames(nz.popn.ta)$region,
                       size = n.region,
                       replace = FALSE)
sim.popn.true <- nz.popn.ta[regions.keep, , , ]
dimnames(sim.popn.true)$region <- paste("Region", seq_along(dimnames(sim.popn.true)$region))

save(sim.popn.true,
     file = "data/sim.popn.true.rda",
     compress = "xz")
