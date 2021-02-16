#' Create a new string of text to the left of a "_"
#' @description
#'
#' @param x a character vector
#' @details
#' use to separate a string into just the part to left of a delimiter such as "-" or "_", also see st_right
#'
#' @export
st_left <- function(x,sep="_") substr(x,1,HeadR::strpos(x,sep)-1)
