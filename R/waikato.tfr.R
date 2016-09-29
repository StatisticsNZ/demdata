#' Total fertility rates in the Waikato region of New Zealand.
#'
#' The total fertility rate is the number of children that a woman would
#' bear over her lifetime if current age-specific fertility rates were to
#' continue indefinitely.
#'
#' The estimates are for the period 2006-2014 and were constructed from
#' \code{\link{nz.births}} and \code{\link{nz.popn.reg}},
#' using function \code{\link[demest]{estimateModel}} in package
#' \code{demest}.  \code{waikato.tfr} contains 1,000 iterations.
#' Variation across the iterations captures uncertainty about the
#' true rates.
#'
#' @format An array with dimensions "year" and "iteration".
#'
#' @source Calculated from \code{\link{nz.births}} and
#' \code{\link{nz.popn.reg}}.
"waikato.tfr"
