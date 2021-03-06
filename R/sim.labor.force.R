
#' Simulated population in labor force by age, sex, and region.
#'
#' One hundred simulated sets of counts of labor force by age, sex, and region.
#' Each region has identical population, which is equal to Current Population Survey
#' estimates of the population in the labor force in the United States in 2014, scaled
#' to sum to approximately 2000 (1989) in each region.
#'
#' @format An array with dimensions "age", "sex", "region", and "iteration".
#' 
#' @seealso \code{link{sim.unemployed}}, \code{\link{sim.unemployment.rate}}
#'
#' @source Modifed from "Employment status of the civilian noninstitutional population
#' by age, sex, and race, retrieved from http://www.bls.gov/cps/cpsaat03.htm on 25 October 2015
"sim.labor.force"
