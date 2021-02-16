#' Count and tag duplicates (in terms of a variable list)
#'
#' @description
#'
#' @param DT a data.table
#' @param by.vars a list of variables
#' @param tag should the fn create an indicator for duplicate obs?
#' @details
#' duplicates resembles Stata command of same name to count and tag repeat observations
#' @export
duplicates <- function(DT,by.vars,tag=FALSE) {
  DT[, dupvar := .N - 1L, by=by.vars]
  cat("Currently there are ",DT[,.N]," observations \n Of which: ",DT[dupvar>=1,.N],"are tagged as duplicates \n")  # is like a duplicates report
  if(tag==FALSE) DT[,dupvar := NULL]
}
