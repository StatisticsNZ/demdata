
set.seed(0)

library(methods)
library(demest)
library(dplyr)

load("data/nz.births.reg.rda")
load("data/nz.popn.reg.rda")

births <- nz.births.reg %>%
    Counts(dimscales = c(year = "Intervals")) %>%
    subarray(year < 2015) %>%
    reallocateToEndAges(min = 15, max = 45) %>%
    subarray(region == "Waikato") %>%
    collapseDimension(dimension = "sex")

females <- nz.popn.reg %>%
    Counts(dimscales = c(year = "Points")) %>%
    subarray(age > 15 & age < 45) %>%
    subarray(sex == "Female") %>%
    subarray(region == "Waikato") %>%
    exposure()

filename <- tempfile()

estimateModel(Model(y ~ Poisson(mean ~ age + year),
                    age ~ DLM(trend = NULL, damp = NULL),
                    jump = 0.08),
              y = births,
              exposure = females,
              filename = filename,
              nBurnin = 1500,
              nSim = 1500,
              nChain = 4,
              nThin = 10)
fetchSummary(filename)
rate <- fetch(filename,
              where = c("model", "likelihood", "rate"))
rate <- thinIterations(rate, n = 100)
waikato.tfr <- tfr(rate)
waikato.tfr <- array(as.numeric(waikato.tfr),
                     dim = dim(waikato.tfr),
                     dimnames = dimnames(waikato.tfr))

save(waikato.tfr,
     file = "data/waikato.tfr.rda",
     compress = "xz")


