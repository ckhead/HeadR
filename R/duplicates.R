#' Count and tag duplicates (in terms of a variable list)
#'
#' @description
#'
#' @param DT a data.table
#' @param by.vars a list of variables
#' @param tag should the fn create an indicator for duplicate obs?
#' @details
#' duplicates() resembles Stata command of same name to count and tag repeat observations
#' Warning: duplicates() uses assign by reference in data.table
#' You must library(HeadR) to use this function
#' Revision note: use copy() to avoid changes to original DT
#' @examples
#' EG <- data.table(x=LETTERS[1:4],y=LETTERS[1:2],z=1:2)
#' duplicates(EG,by.vars=c("x","y","z"))
#' duplicates(EG,by.vars=c("y","z"))
#' EG <- duplicates(EG,by.vars=c("y","z"),tag=TRUE)
#' @export
duplicates <- function(DT,by.vars,tag=FALSE) {
  DW <- copy(DT)
  DW[, dupvar := .N - 1L, by=by.vars]
  cat("Currently there are ",DW[,.N]," observations \n Of which: ",DW[dupvar>=1,.N],"are tagged as duplicates \n")
  if(tag==TRUE) return(DW)  else return(DW[,table(dupvar)])
}
