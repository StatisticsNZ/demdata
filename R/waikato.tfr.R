#' Total fertility rates in the Waikato region of New Zealand.
#'
#' The total fertility rate is the average number of children that a woman would
#' bear over her lifetime if current age-specific fertility rates were to
#' continue indefinitely.
#'
#' The estimates are for the period 1996-2015 and were constructed from
#' \code{\link{nz.births.reg}} and \code{\link{nz.popn.reg}},
#' using function \code{\link[demest]{estimateModel}} in package
#' \code{demest}.  \code{waikato.tfr} contains 100 iterations.
#' Variation across the iterations captures uncertainty about the
#' true rates.
#'
#' @format An array with dimensions "year" and "iteration".
#'
#' @source Calculated from \code{\link{nz.births.reg}} and
#' \code{\link{nz.popn.reg}}.
"waikato.tfr"
