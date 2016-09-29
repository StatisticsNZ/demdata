
## Inputs ##############################################

load("data/us.deaths.rda")
load("data/us.exposure.rda")

rtdistn <- function(n, df, scale) {
    z <- rnorm(n = n)
    x <- rchisq(n = n, df = df)
    scale * z * sqrt(df / x)
}

age.levels <- c(paste(seq(0, 85, 5), seq(4, 89, 5), sep = "-"), "90+")
age <- c(rep(age.levels[1:18], each = 5), rep(age.levels[19], times = 21))
age <- factor(age, levels = age.levels)

deaths <- us.deaths[ , , "2013"]
exposure <- us.exposure[ , , "2013"]

deaths <- apply(deaths, 2, function(x) tapply(x, age, sum))
exposure <- apply(exposure, 2, function(x) tapply(x, age, sum))
names(dimnames(deaths))[1] <- "age"
names(dimnames(exposure))[1] <- "age"

rate.age.sex <- deaths / exposure

sd.age.sex <- 0.1
df.region <- 4
scale.region <- 0.1

n.age.sex <- length(rate.age.sex)
n.region <- 50
n.iter <- 100

exposure.age.sex <- 1e5 * prop.table(exposure)


## Make simulated data #################################

set.seed(1)



log.age.sex <- as.numeric(log(rate.age.sex))
age.sex.error <- rnorm(n = n.age.sex * n.region * n.iter, sd = sd.age.sex)
region.effect <- rtdistn(n = n.region * n.iter, df = 4, scale = scale.region)
region.effect <- rep(region.effect, each = n.age.sex)
log.rates <- log.age.sex + age.sex.error + region.effect
sim.mortality.rate <- exp(log.rates)
dim <- c(dim(deaths), n.region, n.iter)
dimnames <- c(dimnames(deaths),
              list(region = paste("Region", seq_len(n.region)),
                   iteration = seq_len(n.iter)))
sim.mortality.rate <- array(sim.mortality.rate, dim = dim, dimnames = dimnames)
sim.exposure <- array(exposure.age.sex, dim = dim, dimnames = dimnames)
sim.deaths <- rpois(n = length(sim.mortality.rate),
                    lambda = sim.mortality.rate * sim.exposure)
sim.deaths <- array(sim.deaths, dim = dim, dimnames = dimnames)


## Check #################################################

stopifnot(is.integer(sim.deaths))
stopifnot(identical(dimnames(sim.mortality.rate), dimnames(sim.deaths)))
stopifnot(identical(dimnames(sim.mortality.rate), dimnames(sim.exposure)))

if (FALSE) {

    rates.super.df <- as.data.frame.table(sim.mortality.rate, responseName = "rate")
    rates.finite.df <- as.data.frame.table(sim.deaths/sim.exposure, responseName = "rate")
    rates.super.df$age <- factor(rates.super.df$age, levels = age.levels)
    rates.finite.df$age <- factor(rates.finite.df$age, levels = age.levels)

    library(lattice)

    xyplot(rate ~ age | region,
           data = rates.finite.df,
           subset = sex == "Female" & region %in% paste("Region", 1:10) & iteration %in% 1:10,
           groups = iteration,
           type = "l",
           col = "black",
           lwd = 0.5)

    xyplot(log(rate) ~ age | region,
           data = rates.super.df,
           subset = sex == "Female" & region %in% paste("Region", 1:10) & iteration %in% 1:10,
           groups = iteration,
           type = "l",
           col = "black",
           lwd = 0.5)

}

## Save ################################################

save(sim.exposure,
     file = "data/sim.exposure.rda",
     compress = "bzip2")
save(sim.deaths,
     file = "data/sim.deaths.rda",
     compress = "bzip2")
save(sim.mortality.rate,
     file = "data/sim.mortality.rate.rda",
     compress = "bzip2")







