#' Linear interpolation of missing data
#'
#' @description
#'
#' @param xvar the variable to interpolate using (usually year)
#' @param yvar the name of the variable with missing data
#' @details
#' ipolate resembles Stata command of same name to linearly interpolate missing data, and carry forward last observation or backward first observation if extrapolate=TRUE.
#' If you want the identical behavior to Stata, use ipolate_stata() instead.
#' @examples
#' # examples
#' years <- 2000:2005
#' values <- c(1, NA, 3, NA, 5, NA)
#' ipolate(years, values) # should return c(1,2,3,4,5,NA)
#' ipolate(years, values, extrapolate=TRUE) # should return c(1,2,3,4,5,5)
#'
#' years <- 2000:2005
#' values <- c(NA, 2, 3, NA, 5, NA)
#' ipolate(years, values) # should return c(NA,2,3,4,5,NA)
#' ipolate(years, values, extrapolate=TRUE) # should return c(2,2,3,4,5,5)
#' 
#' @export
ipolate <- function(xvar, yvar, extrapolate = FALSE) {
  if (length(yvar[!is.na(yvar)]) >= 2) {
    rule_val <- if (extrapolate) 2 else 1
    z <- approx(xvar, yvar, xout = xvar, rule = rule_val)$y
  } else {
    z <- yvar
  }
  return(z)
}
