#' paste two strings into one with no space between them
#' #' @description
#'
#' @param  x a vector, usually string
#' @param  y a vector, usually string
#' @details
#' an operator to do a simple paste0
#' @examples
#' n = 5
#' "filename" %+% n %+% ".pdf"
#' c(1,NA,3,NA) %+% c(7,5,NA,NA)
#' @export
'%+%' <- function(x,y) paste0(x,y)
