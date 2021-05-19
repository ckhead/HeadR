#' Find position in a string where the first instance of a pattern begins
#'
#' @description
#'
#' @param chr string vector
#' @param pat pattern to locate
#'
#' @details
#' strpos resembles Stata command of same name, returns 0 if pat is absent from chr.
#' This new version is vectorized (the old one failed on the 3rd example)
#' @examples
#' strpos("Coca-Cola","-")
#' strpos("Coca-Cola","Z")
#' strpos(c("WUHU_1","WU_2","WU_HU_WU","WUHUHU_3"),"_")
#' @export
strpos <- function(chr,pat) {
  x <- regexpr(pat,chr,fixed=TRUE)
  return(pmax(x,0))
  }
