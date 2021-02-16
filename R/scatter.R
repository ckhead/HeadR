#' Wrapper for plot/points that defaults to filled transparent circles
#'
#' @description
#'
#' @param a abbreviation for alpha.f, 0=perfectly transparent, 1=solid
#' @param col colour, defaults to black
#' @param pch point type, defaults to filled circles
#' @details
#' To avoid all the typing to get transparent filled circles which is what i want 99% of the time for a scatter plot, i have created this wrapper. Since it defaults to using the same function one should be able to use it in mapply or lapply
#' @export
scatter <- function(...,col="black",a=0.5,pch=16,add=FALSE) {
  if(add) points(...,col=adjustcolor(col,alpha.f = a),pch=pch) else {
    plot(...,col=adjustcolor(col,alpha.f = a),pch=pch)
  }
}
