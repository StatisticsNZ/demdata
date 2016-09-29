
#' Simulated counts of deaths.
#'
#' One hundred simulated sets of counts of deaths by age, sex, and region.
#' The deaths were generated through drawing from Poisson distributions,
#' the expected values for which were equal to
#' \code{\link{sim.mortality.rate}} multiplied by \code{\link{sim.exposure}}.
#'
#' @format An array with dimensions "age", "sex", "region", and "iteration".
#'
#' @source Calculated from \code{\link{us.exposure}} and
#' \code{\link{us.deaths}}.
"sim.deaths"
