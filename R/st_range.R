#' Calculate and display range of a vector of numbers or strings
#'
#' @description
#'
#' @param  x a numeric or string  vector
#' @details
#' returns a character with the lowest and highest values separated by "--" (as in LaTeX)
#' @examples
#' st_range(c(1,3,-1,2))
#' st_range(c("az","zc","x","b"))
#' @export
st_range <- function(x) gsub(", ","--",toString(range(x)))
