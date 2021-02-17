#' List of variables in a data.table with the count of missings
#'
#' @description
#'
#' @param DT a data.table
#' @details
#' where_missing returns a reshaped data table filter to show just variables with missings along with the number of them. if the data.table has no missings, an Empty data.table is returned.
#' You must library(HeadR) to use this function
#' @export
where_missing <- function(DT) {
  missings <-  DT[,lapply(.SD,function(x) sum(is.na(x)))]
  missings <- melt(missings,measure.vars =1:dim(missings)[2],value.name = "n_missing")
  return(missings[n_missing>0])
}
