#' create a column in a data.table with tabular info
#' @description
#'
#' @param 
#' x a list of variables 
#' ndigits number of digits after decimal point
#' @examples 
#' mydt <- data.table(ida=LETTERS[1:10],idn=1:10,x=runif(10),y=runif(10))
#' mydt[,output := texout(list(ida,idn,x,y))]
#' writeLines(mydt$output)
#' mydt[,output := texout(list(ida,idn,x,y),3)]
#' writeLines(mydt$output)
#' @export
texout <- function(x,ndigits=2) {
  glom <- function(x) {
    if(is.wholenumber(x)) paste(x,"&") else
      paste(formatC(x,digits=ndigits,format="f"),"&")
  }
  y <- lapply(x,glom)
  y <-  do.call(paste,y)
  return(sub("&$","\\\\\\\\\\",y))
}
