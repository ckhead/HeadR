#' Create a new string of text to the left of a "_"
#' @description
#'
#' @param x a character vector
#' @param sep a separator character (defaults to "_", don't use backslash)
#' @details
#' use to separate a string into just the part to left of a delimiter such as "-" or "_", also see st_right
#' @examples
#' st_left(c("WUHU_1","WUHU_2","WU_HU_WU","WUHU"))
#' st_left(c("WUHU_1","WUHU/2","WU_HU/WU","WUHU"),"/")
#' @export
st_left <- function(x,sep="_") substr(x,1,HeadR::strpos(x,sep)-1)
