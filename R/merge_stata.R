#' merge.data.table, all, with Stata _merge tracking
#'
#' @description
#'
#' @param DTx  the master data.table
#' @param DTy  the using data.table
#' @param by the variables to merge by as a string vector
#'
#' @examples
#' DT1 <- data.table(i=1:5,x1 = c(1,3,2,4,8))
#' DT2 <- data.table(i=c(3,4,6),y1 = c(7,5,7))
#' DT3 <- merge_stata(DT1,DT2,"i")
#' @export
merge_stata <- function(DTx,DTy, by){  # x,y are data.tables, by is a string of one merge variable.
  x <- copy(DTx)
  y <- copy(DTy)
  x[,stata_master := 1]
  y[,stata_using :=  2]
  DT <- merge(x,y, by = by, all = TRUE)
  DT[,stata_merge := stata_master %+na% stata_using]
  DT[, c("stata_master","stata_using") := NULL]
  print(DT[,.N,by=stata_merge][order(stata_merge)])
  return(DT)
}
