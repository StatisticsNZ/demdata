
#' Simulated mortality rates.
#'
#' One hundred simulated sets of death rates by age, sex, and region.
#' The simulated rates are based on US national-level rates for 2013.  Rates
#' for each simulated region were obtained by perturbing the national-level
#' rates and then randomly shifting the regional rates up or down by a small
#' amount.
#'
#' @format An array with dimensions "age", "sex", "region", and "iteration".
#'
#' @seealso \code{\link{sim.deaths}} and \code{\link{sim.exposure}}
#'
#' @source Calculated from \code{\link{us.exposure}} and
#' \code{\link{us.deaths}}.
"sim.mortality.rate"
