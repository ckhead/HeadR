#' Count number of distinct elements in a vector
#'
#' @description Use data.table::uniqueN() instead
#'
#' @param x a numeric or character vector
#'
#' @export
distinct <- function(x) length(unique(x))
