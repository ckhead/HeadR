#' Operator to test if a string is present in another string
#'
#' @description
#'
#' @param  x a string
#' @param  y a string
#' @details
#' Returns TRUE if the variable to left has the string to the right. Going forward use %like% instead.
#' @export
'%contains%' <- function(x,y) regexpr(y,x) > 0
