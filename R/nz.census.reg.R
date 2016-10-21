

#' Covariate data for New Zealand regions from 2013 Census
#'
#' Columns \code{pr.asian}, \code{pr.european}, \code{pr.maori}
#' \code{pr.pacific} show the proportion of people in each region identifying
#' with an Asian, European, Maori, and Pacific ethnicity.  (Note that people
#' can identify with more than one ethnicity, and do not necessarily
#' identify with any of these ethnicities.)
#'
#' Column \code{pr.inc.50} shows the proportion of adults whose total
#' personal income exceeds $NZ 50,000 per year.
#' 
#' @format An data.frame with columns \code{region}, \code{pr.asian},
#' \code{pr.european}, \code{pr.maori}, \code{pr.pacific}, \code{pr.inc.50}.
#'
#' @source Calculated from data downloaded from Statistics New Zealand website,
#' 25 September 2016.
"nz.census.reg"
