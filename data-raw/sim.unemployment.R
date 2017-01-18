
## Inputs ##############################################

## Source: US unemployment rates for 2014 by age and sex from Current Population Survey
## "HOUSEHOLD DATA, ANNUAL AVERAGES
## 3. Employment status of the civilian noninstitutional population by age, sex, and race"
## Retrieved from http://www.bls.gov/cps/cpsaat03.htm on 25 October 2015


age.levels <- c(paste(seq(15, 70, 5), seq(19, 74, 5), sep = "-"), "75+")

rate.female <- c(17.7, 10.1, 6.8, 6.4, 5.0, 4.7, 4.6, 4.4, 4.2, 4.1, 4.5, 5, 5)
rate.male <- c(21.4, 12.2, 7.4, 5.4, 4.9, 4.4, 4.4, 4.3, 4.4, 4.6, 5.0, 4.5, 3.3)

popn.female <- c(2827, 7459, 7923, 7798, 7276, 7682, 7840, 8322, 7287, 4854, 2199, 918, 654)
popn.male <- c(2827, 8182, 9168, 9310, 8655, 8892, 8798, 9102, 7880, 5481, 2575, 1154, 859)

rate.age.sex <- cbind(rate.female, rate.male)
rownames(rate.age.sex) <- age.levels
rate.age.sex <- 0.01 * rate.age.sex


sd.age.sex <- 0.1
df.region <- 4
scale.region <- 0.1

n.age.sex <- length(rate.age.sex)
n.region <- 50
n.iter <- 100

popn.region <- 2000

popn.age.sex <- cbind(popn.female, popn.male)
rownames(popn.age.sex) <- age.levels
popn.age.sex <- popn.region * prop.table(popn.age.sex)
popn.age.sex <- as.integer(popn.age.sex)

rtdistn <- function(n, df, scale) {
    z <- rnorm(n = n)
    x <- rchisq(n = n, df = df)
    scale * z * sqrt(df / x)
}

logit <- function(x) log(x / (1 - x))
inv.logit <-  function(x) exp(x) / (1 + exp(x))


## Make simulated data #################################

set.seed(1)

logit.age.sex <- logit(rate.age.sex)
logit.age.sex <- as.numeric(logit.age.sex)
age.sex.error <- rnorm(n = n.age.sex * n.region * n.iter, sd = sd.age.sex)
region.effect <- rtdistn(n = n.region * n.iter, df = 4, scale = scale.region)
region.effect <- rep(region.effect, each = n.age.sex)
logit.rates <- logit.age.sex + age.sex.error + region.effect
sim.unemployment.rate <- inv.logit(logit.rates)
dim <- c(length(age.levels), 2, n.region, n.iter)
dimnames <- list(age = age.levels,
                 sex = c("Female", "Male"),
                 region = paste("Region", seq_len(n.region)),
                 iteration = seq_len(n.iter))
sim.unemployment.rate <- array(sim.unemployment.rate, dim = dim, dimnames = dimnames)
sim.labor.force <- array(popn.age.sex, dim = dim, dimnames = dimnames)
sim.unemployed <- rbinom(n = length(sim.unemployment.rate), size = sim.labor.force, prob = sim.unemployment.rate)
sim.unemployed <- array(sim.unemployed, dim = dim, dimnames = dimnames)


## Check #################################################

stopifnot(is.integer(sim.labor.force))
stopifnot(is.integer(sim.unemployed))
stopifnot(identical(dimnames(sim.unemployment.rate), dimnames(sim.labor.force)))
stopifnot(identical(dimnames(sim.unemployment.rate), dimnames(sim.unemployed)))

if (FALSE) {

    rates.super.df <- as.data.frame.table(sim.unemployment.rate, responseName = "rate")
    rates.finite.df <- as.data.frame.table(sim.unemployed/sim.labor.force, responseName = "rate")

    library(lattice)

    xyplot(rate ~ age | region,
           data = rates.finite.df,
           subset = sex == "Female" & region %in% paste("Region", 1:10) & iteration %in% 1:10,
           groups = iteration,
           type = "l",
           col = "black",
           lwd = 0.5)

    xyplot(rate ~ age | region,
           data = rates.super.df,
           subset = sex == "Female" & region %in% paste("Region", 1:10) & iteration %in% 1:10,
           groups = iteration,
           type = "l",
           col = "black",
           lwd = 0.5)

}

## Save ################################################

save(sim.labor.force,
     file = "data/sim.labor.force.rda",
     compress = "bzip2")
save(sim.unemployed,
     file = "data/sim.unemployed.rda",
     compress = "bzip2")
save(sim.unemployment.rate,
     file = "data/sim.unemployment.rate.rda",
     compress = "bzip2")







