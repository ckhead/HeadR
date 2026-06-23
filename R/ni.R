#' Not-in operator
#'
#' @description Negates the \code{\%in\%} operator to exclude elements of a set.
#'
#' @param x a vector, usually a set of id strings
#' @param y a vector, usually a set of id strings
#' @details Returns a logical vector. Equivalent to \code{x != y[1] & x != y[2]} etc.,
#'   but note that \code{y[1]} here is just shorthand -- the actual negation is
#'   computed via \code{!\%in\%} and works for any length \code{y}.
#' @examples
#' c(1, 5, 7, -99, NA) %ni% c(-99, NA)
#' all <- c("Coca-Cola", "Others", "Pepsi", "Private Label")
#' brands <- all[all %ni% c("Others", "Private Label")]
#' @export
'%ni%' <- function(x, y) !('%in%'(x, y))