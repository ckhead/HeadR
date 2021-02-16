#' Do an area shaded confidence interval with transparency
#'
#' @description
#'
#' @param x the x-axis variable in the plot, often time
#' @param b coefficients or means
#' @param se standard errors
#' @param t number of standard errors determining width
#' @details
#' A version of ribbon where user provides estimates and se
#' @export
cipoly <- function(x,b,se,t=1.96,col.fill="darkgrey",alpha.fill=0.4){
  upr <- b+t*se
  lwr <- b-t*se
  polygon.x <- c(x, rev(x))
  polygon.y <- c(lwr, rev(upr))
  polygon(x=polygon.x, y=polygon.y, col=adjustcolor(col.fill, alpha.f=alpha.fill), border=NA)
}
