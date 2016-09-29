
library(demest)
births <- demdata::nz.births
popn <- demdata::nz.popn.reg
births <- Counts(births,
                 dimscales = c(year = "Intervals"))
popn <- Counts(popn,
               dimscales = c(year = "Intervals"))
births <- subarray(births, year > 2005 & year < 2014)
females <- subarray(popn, age > 15 & age < 45 & sex == "Female")
births <- subarray(births, region == "Waikato")
females <- subarray(females, region == "Waikato")
filename <- tempfile()
set.seed(0)
estimateModel(Model(y ~ Poisson(mean ~ age + year),
                    age ~ DLM(trend = NULL, damp = NULL),
                    jump = 0.03),
              y = births,
              exposure = females,
              filename = filename,
              nBurnin = 5000,
              nSim = 5000,
              nChain = 4,
              nThin = 20)
fetchSummary(filename)
rate <- fetch(filename,
              where = c("model", "likelihood", "rate"))
waikato.tfr <- tfr(rate)
waikato.tfr <- array(as.numeric(waikato.tfr),
                     dim = dim(waikato.tfr),
                     dimnames = dimnames(waikato.tfr))
save(waikato.tfr,
     file = "data/waikato.tfr.rda",
     compress = "xz")


