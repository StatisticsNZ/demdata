
#' Permament and long-term arrivals to and departures from New Zealand,
#' 1997-2016.
#'
#' A permanent and long-term arrival is an international arrival of a
#' person who intends to reside in the country for at least on year.
#' A permanent and long-term departure is an international departure
#' of a person who intends to reside out of the country for at least
#' one year.
#'
#' The data are for June years. For instance, data for the year
#' "1997" refer to the period 1 July 1996 to 30 June 1997.
#'
#' The data are disaggregated by age, sex, territorial authority,
#' year, and direction ("Arrival" or "Departure").
#'
#' The territorial authority is the
#' most important sub-national administrative unit in
#' New Zealand. In 2010, seven territorial authorities were
#' amalgamated to form a single Auckland region. \code{nz.intl.migr}
#' uses the pre-amalgamation boundaries for 1997-2010 and
#' post-amalgamation boundary for 2011-2016.
#' 
#' @format An array with dimensions "region", "age", "sex", "year",
#' and "direction".
#'
#' @seealso \code{\link{nz.popn.ta}}
#' 
#' @source Calculated from data on Statistics New Zealand website.
#' Downloaded 6 March 2017.
"nz.intl.migr"
