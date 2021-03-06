% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/texout.R
\name{texout}
\alias{texout}
\title{create a column in a data.table with tabular info}
\usage{
texout(x, digits = 2)
}
\arguments{
\item{x}{a list of variables}

\item{digits}{number of digits after decimal point}
}
\description{

}
\details{
texout() is designed to be used inside a data.table. it takes a list of variables and checks for which are whole numbers.
the whole numbers are not altered. the real numbers are formatted fixed.
LaTeX column separators "&" are place between numbers and  backslashes are used at the end.
}
\examples{
mydt <- data.table(ida=LETTERS[1:10],idn=1:10,x=runif(10),y=runif(10))
mydt[,output := texout(list(ida,idn,x,y))]
writeLines(mydt$output)
mydt[,output := texout(list(ida,idn,x,y),3)]
writeLines(mydt$output)
}
