
#' Simulated population exposed to risk of dying.
#'
#' One hundred simulated sets of counts of population by age, sex, and region.
#' Each region has an identical population, which is equal to
#' estimates of the population of the United States in 2013, scaled
#' to sum to 100,000 in each region.
#'
#' @format An array with dimensions "age", "sex", "region", and "iteration".
#'
#' @seealso \code{link{sim.deaths}}, \code{\link{sim.mortality.rate}}
#'
#' @source Calculated from \code{\link{us.exposure}}.
"sim.exposure"
