
#' Simulated survey data.
#'
#' The dataset is constructed by taking selecting 5\% of the \code{\link{sim.popn.true}}
#' population, using function \code{\link{rbinom}}.
#'
#' @format  An array with dimensions \code{"age"}, \code{"sex"}, \code{"region"},
#' and \code{"year"}.
#'
#' @seealso The other simulated administrative datasets are
#' \code{\link{sim.admin.health}}, \code{\link{sim.admin.nat}},
#' and \code{\link{sim.admin.school}}.  The underlying "simulation-true"
#' population counts are \code{\link{sim.popn.true}}.
"sim.admin.survey"
