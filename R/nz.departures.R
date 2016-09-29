
#' Permament and long-term departures in New Zealand, 1991-2015.
#'
#' A permanent and long-term departure is an depatures from
#' New Zealand of a person who intends to stay out of
#' the country for at least one year.
#'
#' The data are disaggregated by age, sex, calendar year, and
#' territorial authority.  The territorial authority is the
#' most important sub-national administrative unit in
#' New Zealand.
#'
#' In 2010, seven territorial authorities were
#' amalgamated to form a single Auckland region.  \code{nz.departures}
#' uses the post-amalgamation boundaries for the entire
#' period 1991-2015.
#' 
#' @format An array with dimensions "region", "age", "sex", and "year".
#'
#' @seealso \code{\link{nz.arrivals}}, \code{\link{nz.popn.ta}}
#' 
#' @source Calculated from data on Statistics New Zealand website.
#' Downloaded 21 July 2016.
"nz.departures"
