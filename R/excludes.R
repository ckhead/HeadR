#' Operator to see if a string does not contain another string
#' @description
#'
#' @param x a character vector
#' @param y a character vector
#'
#' @details
#' Returns a logical if LHS does not have RHS inside it
#' @export
'%excludes%' <- function(x,y) !grepl(y,x,fixed=T)
