
#' Simulated school enrolment data.
#'
#' The data set is constructed by subsetting taking population counts for
#' \code{\link{sim.popn.true}} for ages \code{"5-9"} and \code{"10-14"} and adding
#' some random noise.
#'
#' @format  An array with dimensions \code{"age"}, \code{"sex"}, \code{"region"},
#' and \code{"year"}.
#'
#' @seealso The other simulated administrative datasets are
#' \code{\link{sim.admin.health}}, \code{\link{sim.admin.nat}},
#' and \code{\link{sim.admin.survey}}.  The underlying "simulation-true"
#' population counts are \code{\link{sim.popn.true}}.
"sim.admin.school"
