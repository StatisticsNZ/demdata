
#' Non-fatal injurines in New Zealand.
#'
#' Counts of non-fatal injuries in New Zealand, by year, age, sex, and cause.
#'
#' The original dataset only included work-related injuries, but not
#' other injuries, for the years 2014 and 2015, so these years
#' have been excluded from from \code{nz.injuries}.
#'
#' @format A data.frame with 727 rows and the following variables:
#' \describe{
#'   \item{year}{Calendar year in which the injury occurred.}
#'   \item{age}{Age, in broad age groups.}
#'   \item{sex}{Female or male.}
#'   \item{cause}{Cause of injury.}
#'   \item{count}{Number of injuries.}
#' }
#'
#' @source Table "Count of fatal and serious non-fatal injuries by sex,
#' age group, ethnicity, cause, and severity of injury, 2000-15" on
#' Statistics New Zealand website. Downloaded 3 July 2017.
"nz.injuries"
