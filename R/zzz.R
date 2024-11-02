#' @import data.table

.onLoad <- function(libname, pkgname) {
  requireNamespace("data.table", quietly = TRUE)
}
