
## Enrolment in health system.  Coverage varies by age

set.seed(0)

load("data/sim.popn.true.rda")

coverage <- c("0-4" = 0.99,
              "5-9" = 0.97,
              "10-14" = 0.95,
              "15-19" = 0.9,
              "20-24" = 0.8,
              "25-29" = 0.85,
              "30-34" = 0.9,
              "35-39" = 0.95,
              "40-44" = 0.97,
              "45-49" = 0.97,
              "50-54" = 0.97,
              "55-59" = 0.97,
              "60-64" = 0.97,
              "65-69" = 0.97,
              "70-54" = 0.97,
              "75-59" = 0.97,
              "80-84" = 0.97,
              "85+" = 0.97)
coverage <- rep(coverage, each = dim(sim.popn.true)[1])
sim.admin.health <- rpois(n = length(sim.popn.true),
                          lambda = coverage * sim.popn.true)
sim.admin.health <- array(sim.admin.health,
                          dim = dim(sim.popn.true),
                          dimnames = dimnames(sim.popn.true))

save("sim.admin.health",
     file = "data/sim.admin.health.rda",
     compress = "xz")
