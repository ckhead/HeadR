#' Paste together strings
#' 
#' #' @description paste two strings into one with no space between them
#'
#' @param  x a vector, usually string
#' @param  y a vector, usually string
#' @details a plus operator to do a simple paste0, similar to Stata
#' @examples
#' n = 5
#' "filename" %+% n %+% ".pdf"
#' c(1,NA,3,NA) %+% c(7,5,NA,NA)
#' @export
'%+%' <- function(x,y) paste0(x,y)
