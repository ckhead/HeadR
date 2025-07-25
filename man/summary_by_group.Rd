% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary_by_group.R
\name{summary_by_group}
\alias{summary_by_group}
\title{Compute Summary Statistics by Group}
\usage{
summary_by_group(dt, var, group)
}
\arguments{
\item{dt}{A \code{data.table} containing the data.}

\item{var}{A character string giving the name of the numeric variable to summarize.}

\item{group}{A character string giving the name of the grouping variable.}
}
\value{
A \code{data.table} with one row per group and columns for the grouping variable,
minimum, 1st quartile (Q1), median, mean, 3rd quartile (Q3), and maximum.
}
\description{
Computes common summary statistics (minimum, 1st quartile, median, mean, 3rd quartile, maximum)
for a specified numeric variable within groups of a data.table.
}
\details{
The function is designed to work efficiently with \code{data.table}.
It uses standard summary statistics and handles missing values (\code{NA}) by default through \code{na.rm = TRUE}.
}
\examples{
library(data.table)
dt <- data.table(group = rep(letters[1:3], each = 10),
                 x = rnorm(30))

# Summarize 'x' by 'group'
summary_by_group(dt, var = "x", group = "group")

}
