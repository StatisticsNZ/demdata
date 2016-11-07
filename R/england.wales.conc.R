#' Concordance between Local Administrative District (LAD) and Region in
#' England and Wales, 2014.
#'
#' The names come from the Office for National Statistics website, but
#' modified to make the Local Administrative District (LAD) names
#' consistent with those for \code{\link{england.wales.popn}}.
#' For the purposes of the concordance, the country of Wales has been
#' is referred to as a region.
#'
#' @format A data.frame with columns 'lad' and 'rgn'.
#'
#' @source Lookup table "LAD15_RGN15_EN_LU.csv" downloaded from the
#' ONS website on 4 November 2016, plus \code{\link{england.wales.deaths}}.
"england.wales.conc"
