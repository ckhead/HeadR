#' create a column in a data.table with tabular info
#' @description
#' @import data.table
#' @param x a list of variables
#' @param digits number of digits after decimal point
#' @details
#' str2tex_col() is designed to be used inside a data.table. it takes a list of variables and a list of round digits with selected columns.
#' the whole numbers are altered as well. the real numbers are formatted fixed. It is the updated version of texout() function.
#' LaTeX column separators "&" are place between numbers and  backslashes are used at the end.
#' The last line is without "\\". Also keep the Int format of last element (if applicable)
#' @examples
#' data <- data.table(A = 1:5,B = c(1, 2.1234, 3.1234, 4.1234, 5.1234),C = c(1000.55, 2000.75, 3000.95, 4000.15, 5000.35),D = 1:5,E = c("a", "b", "c", "d", "e"))
#' data[,output := str2tex_col(list(A,B,C,D,E), rounding = c(0, 2, 1, 0), col_select = c(1, 2, 3, 4))
#' writeLines(mydt$output)
#' @export

str2tex_col <- function(data, rounding = NULL, col_select = NULL) {
  # Ensure the input is converted to a data.table
  data <- as.data.table(data)

  # Select specific columns if provided
  if (!is.null(col_select)) {
    data <- data[, ..col_select]
  }

  # Set default rounding if not provided
  if (is.null(rounding)) {
    rounding <- rep(0, ncol(data))
  }

  # Ensure rounding vector matches the number of columns
  if (length(rounding) != ncol(data)) {
    stop("The length of the rounding vector must match the number of columns in the data.")
  }

  # Format rows: process each column using its corresponding rounding value
  formatted_rows <- data[, lapply(seq_len(ncol(data)), function(col_idx) {
    col_data <- .SD[[col_idx]]
    if (is.numeric(col_data)) {
      # round(col_data, digits = rounding[col_idx])
      formatC(col_data,digits=rounding[col_idx],format="f")
    } else {
      col_data
    }
  }), .SDcols = seq_len(ncol(data))]

  # Combine rows into LaTeX-compatible strings
  formatted_strings <- apply(formatted_rows, 1, function(row) {
    paste(row, collapse = " & ")
  })

  # Add LaTeX line breaks
  formatted_strings <- paste0(formatted_strings, " \\\\\\\\")

  # Return the formatted strings
  return(formatted_strings)
}
