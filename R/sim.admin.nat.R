
#' Simulated national-level administrative data.
#'
#' The dataset was constructed by aggregating over the \code{region} dimension
#' of \code{\link{sim.popn.true}}, and then adding a small amount of random
#' noise.
#' 
#' @format  An array with dimensions \code{"age"}, \code{"sex"}, and \code{"year"}.
#'
#' @seealso The other simulated administrative datasets are
#' \code{\link{sim.admin.health}}, \code{\link{sim.admin.school}},
#' and \code{\link{sim.admin.survey}}.  The underlying "simulation-true"
#' population counts are \code{\link{sim.popn.true}}.
"sim.admin.nat"
