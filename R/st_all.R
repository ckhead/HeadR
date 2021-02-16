#' Take a vector of strings and tack sorted uniques together separating with "-"
#'
#' @description
#'
#' @param  x a numeric or string  vector
#' @details
#' returns a single string from a vector, useful in by commands to keep all the unique values, sorted and hyphenated
#' Default separator not work well with negative numbers or if string already contains hyphenation, switch to "|"
#' @examples
#' st_all(c(1,3,1,2))
#' st_all(c("AZ","Pfizer","Moderna","AZ"))
#' st_all(c(1,3,-1,2),"|")
#' @export
st_all <- function(x,sep="-") gsub(", ",sep,toString(sort(unique(x))))
