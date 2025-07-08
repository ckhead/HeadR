#' Match codes from something to something
#'
#' @param code code to map
#' @param from name of column from which to map
#' @param to name of column to which to map
#' @param dictionary data.frame with mapping
#' @export
match_replace <- function (code, from, to, dictionary) {
  dictionary[match(code, dictionary[[from]]),][[to]]
}