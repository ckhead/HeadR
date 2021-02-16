#' Do an area shaded ribbon with transparency
#'
#' @description
#'
#' @param x the x-axis variable in the plot, often time
#' @param y_lo lower edge of the ribbon
#' @param y_hi upper edge of the ribbon
#' @param coll.fill colour to fill the ribbon
#' @param alpha.fill transparency parameter, lower is lighter
#' @param coll.edge colour to outline the upper and lower bounds
#' @param alpha.edge transparency parameter, set to 1 for no transparency
#' @details
#' A more general version of cipoly, for example when you have bootstrap CIs
#' @examples
#' plot(1:10,type="n",ylim=c(0,15))
#' ribbon(1:10,2:11,4:13,col.fill="blue",col.edge="blue",alpha.edge=1)
#' ribbon(1:10,11:2,13:4,col.fill="red",col.edge="red")
#' @export
ribbon <- function(x,y_lo,y_hi,col.fill="darkgrey",alpha.fill=0.4,col.edge="darkgrey",alpha.edge=0.4){
  polygon.x <- c(x, rev(x))
  polygon.y <- c(y_lo, rev(y_hi))
  polygon(x=polygon.x, y=polygon.y, col=adjustcolor(col.fill, alpha.f=alpha.fill), border=NA)
  lines(x,y_lo,col=adjustcolor(col.edge, alpha.f=alpha.edge))
  lines(x,y_hi,col=adjustcolor(col.edge, alpha.f=alpha.edge))
}
