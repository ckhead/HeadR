#' Linear interpolation of missing data
#'
#' @description
#'
#' @param xvar the variable to interpolate using (usually year)
#' @param yvar the name of the variable with missing data
#' @details
#' ipolate resembles Stata command of same name, very little testing on this fn
#' @export
ipolate <- function(xvar,yvar) {
  if(length(yvar[!is.na(yvar)]) >= 2) z <- approx(xvar,yvar,xout=xvar)$y else z <- yvar
  return(z)
}
