#' Remove leftover LaTeX files
#'
#' @description
#'
#' @param path folder, defaults to current directory
#' @param ext character vector of file extensions, defaults to 7 Beamer extensions (not tex or pdf!) and two book extensions
#' @param del logical to say whether to delete or just list the files, defaults to FALSE
#' @param bib logical to say whether to delete bbl and blg files, defaults to TRUE
#' @details
#' defaults to concatenating all the files Beamer creates, but can change to get list of other sets of files
#' when del= TRUE the files are removed.
#'  #' @examples
#'  clean_dir("Lectures/Slides2018")
#' clean_dir("Lectures/Slides2018",del=TRUE)
#' clean_dir()
#' @export
clean_dir <- function(path=".",ext = c("aux","snm","toc","log","out","nav","gz","lof","lot"),del=FALSE,bib=TRUE) {
  if(bib==TRUE) ext <- c(ext,c("bbl","blg"))  # append the bibtex extensions
  x <- paste0(ext,"$")
  y <- NULL
  for(i in x) {
    y = c(y,list.files(path=path,pattern=i))
  }
if(del==TRUE) file.remove(file.path(path,y)) else return(y)
}



