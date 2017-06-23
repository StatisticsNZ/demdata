
#' Internal migration flows between census years, in New Zealand, 1996-2013.
#'
#' The data come from the "address 5 year ago" question in the population
#' census.  \code{"region_orig"} is the person's region 5 years before
#' the census, and \code{"region_dest"} is the person's region
#' at the time of the census.  The counts have been rounded to
#' multiples of 3, and counts below 6 are missing, to preserve
#' confidentiality.
#'
#' @format An array with dimensions "age", "sex", "region_orig",
#' "region_dest", and "year"
#'
#' @source Custom tabulation from Statistics New Zealand.
#'
#' @seealso \code{\link{nz.popn.reg}}, \code{\link{nz.births.reg}},
#' \code{\link{nz.deaths.reg}}, \code{\link{nz.ext.mig.reg}}.
"nz.int.mig.reg"
