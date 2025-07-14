#' Compute Summary Statistics by Group
#'
#' Computes common summary statistics (minimum, 1st quartile, median, mean, 3rd quartile, maximum)
#' for a specified numeric variable within groups of a data.table.
#' 
#' @param dt A `data.table` containing the data.
#' @param var A character string giving the name of the numeric variable to summarize.
#' @param group A character string giving the name of the grouping variable.
#'
#' @return A `data.table` with one row per group and columns for the grouping variable,
#' minimum, 1st quartile (Q1), median, mean, 3rd quartile (Q3), and maximum.
#'
#' @details The function is designed to work efficiently with `data.table`. 
#' It uses standard summary statistics and handles missing values (`NA`) by default through `na.rm = TRUE`.
#'
#' @examples
#' library(data.table)
#' dt <- data.table(group = rep(letters[1:3], each = 10),
#'                  x = rnorm(30))
#' 
#' # Summarize 'x' by 'group'
#' summary_by_group(dt, var = "x", group = "group")
#'
#' @export
summary_by_group <- function(dt, var, group) {
  # Ensure input is a data.table
  stopifnot(is.data.table(dt))
  
  # Evaluate column names dynamically
  dt[, .(
    Min    = min(get(var), na.rm = TRUE),
    Q1     = quantile(get(var), 0.25, na.rm = TRUE),
    Median = median(get(var), na.rm = TRUE),
    Mean   = mean(get(var), na.rm = TRUE),
    Q3     = quantile(get(var), 0.75, na.rm = TRUE),
    Max    = max(get(var), na.rm = TRUE)
  ), by = group]
}
