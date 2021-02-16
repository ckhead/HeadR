#' Make numbers look nice for a table
#' @param x a number
#' @param digits the number of digits to show to right of decimal point
#' @description
#' Warning the result is not numeric anymore, so do not do any calculations
#' @examples
#'  nice(c(17.0003,4.726677))
#' nice(c(17.0003,4.726677),digits=0)
#' @export
nice <- function(x,digits=2) formatC(x,digits=digits,format="f",big.mark=",")
