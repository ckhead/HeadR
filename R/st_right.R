#' Create a new string of text to the right of a "_"
#' @description
#'
#' @param x a character vector
#' @param sep a separator character (defaults to "_")
#' @details
#' use to separate a string into just the part to right of a delimiter such as "-" or "_", also see st_left
#'
#' @export
st_right <- function(x,sep="_") substr(x,HeadR::strpos(x,sep)+1,nchar(x))
