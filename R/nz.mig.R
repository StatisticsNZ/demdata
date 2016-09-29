
#' Census Data on migration between New Zealand's two main islands.
#'
#' Data on migration flows between New Zealand's North and South Islands
#' derived from the 2006 Population Census.  The data are disaggregated by
#' broad age groups and by sex.
#'
#' The data only incude people who were aged 15+ in 2006 who were
#' residents of New Zealand at that time, and who had been residents in
#' 2001. It excludes non-responses and people on outlying islands.
#'
#' The \code{"island_orig"} indicates residence in 2001 and
#' \code{"island_dest"} indicates residence in 2006.
#'
#' @format An array with dimensions "age", "sex", "island_orig", and "island_dest".
#'
#' @source Custom tabulation from Statistics New Zealand.
"nz.mig"
