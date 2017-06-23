
#' Registered births in New Zealand by age, sex, and region, 1997-2016.
#'
#' The \code{"age"} variable refers to the age of the mother, and the \code{"sex"}
#' variable refers to the sex of the child.
#'
#' The years are June years.  For instance, the year "1997" runs from 1 July 1996
#' to 30 Jun 1997.
#' 
#' All births to mothers aged less than 20 (included those to mothers aged less than
#' 15) have been included in age group \code{"15-19"}, and all births to mothers aged
#' 45 or higher (including those to mothers aged 50+) have been included in age
#' group \code{"45-49"}.
#' 
#' @format An array with dimensions "age", "sex", "region", and "year"
#'
#' @source Custom tabulation from Statistics New Zealand.
#'
#' @seealso \code{\link{nz.popn.reg}}, \code{\link{nz.deaths.reg}},
#' \code{\link{nz.int.mig.reg}}, \code{\link{nz.ext.mig.reg}}.
"nz.births.reg"
