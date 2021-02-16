#' Find position in a string where the first instance of a pattern begins
#'
#' @description
#'
#' @param chr string vector
#' @param pat pattern to locate
#'
#' @details
#' strpos resembles Stata command of same name, returns 0 if pat is absent from chr.
#' @examples
#' strpos("Coca-Cola","-")
#' strpos("Coca-Cola","Z")
#'
#' @export
strpos <- function(chr,pat) {
  x <- regexpr(pat,chr,fixed=TRUE)[[1]]
  return(max(x,0))
  }
