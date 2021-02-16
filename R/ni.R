#' not-in operator to exclude elements of a set.
#'
#' @description
#'
#' @param  x a vector, usually a set of id strings
#' @details
#' Negates the %in% operator. Returns a logical. Equivalent to keep if x != y[1] and x!= y[2], etc.
#' @export
'%ni%' <- function(x,y) {
  !('%in%'(x,y))
}
