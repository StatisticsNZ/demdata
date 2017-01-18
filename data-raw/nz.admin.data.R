
## Simulate administrative data based on dataset 'nz.popn'

## True population ############################################################

load("data/nz.popn.ta.rda")
true.popn <- nz.popn.ta
dimnames(true.popn)$region <- paste("Region", seq_along(dimnames(true.popn)$region))


## sim.admin.nat ##############################################################

## Dataset that is accurate, but only available at national level.
## Generated using Poisson-binomial mixture.

nat.expected <- apply(true.popn, MARGIN = c("age", "sex", "year"), sum)
p <- 0.98
n <- length(nat.expected)
correctly.counted <- rbinom(n = n, size = nat.expected, prob = p)
overcount <- rpois(n = n, lambda = (1 - p) * nat.expected)
sim.admin.nat <- array(correctly.counted + overcount,
                      dim = dim(nat.expected),
                      dimnames = dimnames(nat.expected))
save("sim.admin.nat",
     file = "data/sim.admin.nat.rda",
     compress = "xz")


## sim.admin.school ##############################################################

## Accurate data for 'school ages', taken to be 5-14.
## Generated using Poisson-binomial mixture.

school.expected <- true.popn[, c("5-9", "10-14"), , ]
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


## sim.admin.health ##############################################################

## Coverage varies by age

set.seed(1)
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
coverage <- rep(coverage, each = dim(true.popn)[1])
sim.admin.health <- rpois(n = length(true.popn),
                          lambda = coverage * true.popn)
sim.admin.health <- array(sim.admin.health,
                         dim = dim(true.popn),
                         dimnames = dimnames(true.popn))
save("sim.admin.health",
     file = "data/sim.admin.health.rda",
     compress = "xz")



## sim.admin.survey ##############################################################

set.seed(1)
p.survey <- 0.05
true.popn.5 <- true.popn[ , , , c("2000", "2005", "2010", "2015")]
n <- length(true.popn.5)
sim.admin.survey <- rbinom(n = n, size = true.popn.5, prob = 0.05)
sim.admin.survey <- array(sim.admin.survey,
                          dim = dim(true.popn.5),
                          dimnames = dimnames(true.popn.5))
save("sim.admin.survey",
     file = "data/sim.admin.survey.rda",
     compress = "xz")





