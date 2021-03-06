
#' Simulated unemployment rate by age, sex, and region.
#'
#' One hundred simulated sets of unemployment rates by age, sex, and region.
#' The rates were generated by adding random noise to national-level
#' unemployment rates by age and sex for the United States in 2014.
#'
#' @format An array with dimensions "age", "sex", "region", and "iteration".
#'
#' @seealso \code{link{sim.unemployed}}, \code{\link{sim.labor.force}}
#'
#' @source Modifed from "Employment status of the civilian noninstitutional population
#' by age, sex, and race, retrieved from http://www.bls.gov/cps/cpsaat03.htm on 25 October 2015
"sim.unemployment.rate"
