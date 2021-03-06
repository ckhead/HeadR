% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_wholenumber.R
\name{is_wholenumber}
\alias{is_wholenumber}
\title{Logical to test if a number is a whole number (out to machine precision)}
\usage{
is_wholenumber(x, tol = .Machine$double.eps^0.5)
}
\arguments{
\item{x}{a number}
}
\description{
Warning the result is not numeric anymore, so do not do any calculations
}
\examples{
is_wholenumber(7)
is_wholenumber(7.00)
is_wholenumber(7.001)
is_wholenumber(7.000000001)
}
