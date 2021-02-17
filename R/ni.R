#' not-in operator to exclude elements of a set.
#'
#' @description
#'
#' @param  x a vector, usually a set of id strings
#' @param  y a vector, usually a set of id strings
#' @details
#' Negates the %in% operator. Returns a logical. Equivalent to keep if x != y[1] and x!= y[2], etc.
#' @examples
#' c(1,5,7,-99,NA) %ni% c(-99,NA)
#' all <- c("Coca-Cola","Others","Pepsi","Private Label")
#' brands <- all[all %ni% c("Others","Private Label")]
#' @export
'%ni%' <- function(x,y) {
  !('%in%'(x,y))
}
