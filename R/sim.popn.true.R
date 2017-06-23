
#' Simulated population data.
#'
#' The dataset was obtained by randomly selecting 20 regions from the New Zealand
#' population data \code{\link{nz.popn.ta}}.
#'
#' The acts as the underlying counts, or "simulation truth", for datasets
#' \code{\link{sim.admin.nat}}, \code{\link{sim.admin.health}},
#' \code{\link{sim.admin.school}}, and \code{\link{sim.admin.survey}}.  
#' 
#' @format  An array with dimensions \code{"age"}, \code{"sex"}, \code{"region"},
#' and \code{"year"}.
#'
#' @seealso The data were created from \code{\link{nz.popn.ta}}.
"sim.popn.true"
