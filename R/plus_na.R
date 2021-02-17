#' when adding an NA keep the non-missing term in the sum
#' @description
#'
#' @param  x a numeric vector
#' @param  y a numeric vector
#' @details
#' sum that does not fail when adding a missing and a non-missing:
#' used in HeadR::merge_stata
#' #' @examples
#' 2 %+na% NA
#' c(1,NA,3,NA) %+na% c(7,5,NA,NA)
#' @export
'%+na%' <- function(x,y) {ifelse( is.na(x), y, ifelse( is.na(y), x, x+y) )}

