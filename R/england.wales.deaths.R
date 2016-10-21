#' Deaths in England and Wales in 2014 by Age, Sex, and Local Administrative
#' District (LAD).
#'
#' The data are from the Office for National Statistics website, but
#' modified to make the Local Administrative District (LAD) names
#' consistent with those for \code{\link{england.wales.popn}}.  The
#' districts "Isles of Scilly" and "Cornwall" are combined in the original
#' data.  The 'lad' dimension includes the category "Usual residence
#' outside England and Wales".  
#'
#' @format An array with dimensions "age", "sex", and "lad".
#'
#' @source Dataset "deathsarea2014tcm77431322" downloaded from the
#' ONS website on 21 October 2016.
"england.wales.deaths"
