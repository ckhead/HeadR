#' create a column in a data.table with tabular info
#' @description
#'
#' @param x a list of variables
#' @param digits number of digits after decimal point
#' @details
#' texout() is designed to be used inside a data.table. it takes a list of variables and checks for which are whole numbers.
#' the whole numbers are not altered. the real numbers are formatted fixed.
#' LaTeX column separators "&" are place between numbers and  backslashes are used at the end.
#' @examples
#' mydt <- data.table(ida=LETTERS[1:10],idn=1:10,x=runif(10),y=runif(10))
#' mydt[,output := texout(list(ida,idn,x,y))]
#' writeLines(mydt$output)
#' mydt[,output := texout(list(ida,idn,x,y),3)]
#' writeLines(mydt$output)
#' @export
texout <- function(x,digits=2) {
  glom <- function(x) {
    if(HeadR::is_wholenumber(x)) paste(x,"&") else
      paste(formatC(x,digits=digits,format="f"),"&")
  }
  y <- lapply(x,glom)
  y <-  do.call(paste,y)
  return(sub("&$","\\\\\\\\\\",y))
}

#' the last line is without '\\'. Also keep the Int format of last element (if applicable)
str2tex<-function (x, digits = 2)
{
  glom <- function(x) {
    if (is_wholenumber(x)){
      paste(x, "&")
    }
    else if(is.character(x)){
      paste(x, "&")
    }
    else {
      paste(formatC(as.numeric(x), digits = digits, format = "f"),
            "&")
    }
  }
  for (i in 1:length(x)){
    x[[i]] <- lapply(x[[i]], glom)
  }
  x <- do.call(paste, x)
  for (i in 1:length(x)-1){
    x[i] = sub("&$", "\\\\\\\\\\", x[i])
  }
  x[length(x)] = sub("&$", "", x[length(x)])
  return(x)
}
