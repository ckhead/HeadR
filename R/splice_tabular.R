#' Splice a values table with a parenthetical table into a LaTeX tabular
#'
#' Interleaves two \code{data.table}s that share an id column and the same
#' set of numeric columns -- a "main" table (e.g. point estimates) and a
#' "secondary" table (e.g. standard errors) -- into a single LaTeX
#' \code{tabular} environment. Each id gets two rows: the main values on the
#' first row (with the id label), and the secondary values in parentheses on
#' the row below (with a blank id cell, since it would be redundant).
#'
#' Rows in \code{secondary} are matched to \code{main} by \code{id.var}, not
#' by row position, so \code{secondary} need not be pre-sorted to match
#' \code{main}. Every id in \code{main} must appear exactly once in
#' \code{secondary}.
#'
#' @param main      A \code{data.table} (or object coercible via
#'   \code{\link[data.table]{as.data.table}}) with an id column plus numeric
#'   columns, e.g. coefficient estimates or means.
#' @param secondary A \code{data.table} with the same id column and the same
#'   numeric columns as \code{main}, e.g. standard errors or standard
#'   deviations. One row per id, matched to \code{main} by id.
#' @param id.var    Character. Name of the id column. Default \code{"id"}.
#' @param digits    Number of decimal places to round numeric columns to.
#'   Either a single integer applied to all numeric columns (default
#'   \code{3}), or a named vector/list giving digits per column, e.g.
#'   \code{c(beta = 3, se = 4)}.
#' @param col.names Optional character vector of header labels for the
#'   non-id columns, in the same order as they appear in \code{main}.
#'   Defaults to the column names themselves.
#' @param file      Optional path to write the \code{.tex} output to via
#'   \code{\link[base]{writeLines}}. If \code{NULL} (default), nothing is
#'   written to disk and only the character vector of lines is returned.
#' @param align     Optional column alignment string for the tabular, e.g.
#'   \code{"lcc"}. Defaults to \code{"l"} for the id column followed by
#'   \code{"r"} for every numeric column.
#' @param booktabs  Logical. If \code{TRUE} (default), use
#'   \code{\\toprule}/\code{\\midrule}/\code{\\bottomrule} (requires the
#'   LaTeX \code{booktabs} package). If \code{FALSE}, use \code{\\hline}
#'   for the top, header, and bottom rules instead.
#' @param standalone Logical. If \code{TRUE}, wrap the tabular in a full
#'   \code{table} environment (\code{\\begin\{table\}...\\end\{table\}}),
#'   with \code{\\centering} and, if supplied, \code{\\caption} and
#'   \code{\\label}. Default \code{FALSE} returns a bare \code{tabular}
#'   environment, suitable for \code{\\input\{\}}-ing into a larger document.
#' @param caption   Optional caption string, used only when
#'   \code{standalone = TRUE}.
#' @param label     Optional label string, used only when
#'   \code{standalone = TRUE}.
#'
#' @return Invisibly, a character vector of the LaTeX lines written (or that
#'   would have been written if \code{file} were supplied).
#'
#' @examples
#' library(data.table)
#'
#' ## Basic use: means with standard deviations underneath
#' main <- data.table(id = c("id1", "id2"),
#'                     a  = c(1.2345, 3.4567),
#'                     b  = c(5.6789, 7.8901))
#' secondary <- data.table(id = c("id1", "id2"),
#'                          a  = c(0.111, 0.222),
#'                          b  = c(0.333, 0.444))
#'
#' splice_tabular(main, secondary)
#'
#' \dontrun{
#' ## Write directly to a .tex file for \\input{} into a paper
#' splice_tabular(main, secondary, file = "means_sd.tex")
#' }
#'
#' ## Per-column digits and custom header labels
#' splice_tabular(main, secondary,
#'                digits = c(a = 2, b = 4),
#'                col.names = c("Mean X", "Mean Y"))
#'
#' ## secondary need not be pre-sorted to match main, and may contain NAs
#' ## (NA cells are left blank rather than printed as "NA")
#' main2 <- data.table(id = c("firm1", "firm2", "firm3"),
#'                      mean_x = c(10.5, 20.25, 30.125),
#'                      mean_y = c(1.5, 2.5, 3.5))
#' secondary2 <- data.table(id = c("firm2", "firm1", "firm3"),
#'                           mean_x = c(0.5, 0.25, NA),
#'                           mean_y = c(0.1, 0.2, 0.3))
#' splice_tabular(main2, secondary2)
#'
#' ## Wrap in a full table environment with caption and label, using \\hline
#' ## instead of booktabs rules
#' splice_tabular(main, secondary,
#'                standalone = TRUE,
#'                booktabs = FALSE,
#'                caption = "Means and standard deviations",
#'                label = "tab:meansd")
#'
#' ## id labels containing LaTeX special characters are escaped automatically
#' main3 <- data.table(id = c("A&B_co", "100%"), x = c(1.1, 2.2))
#' secondary3 <- data.table(id = c("A&B_co", "100%"), x = c(0.1, 0.2))
#' splice_tabular(main3, secondary3)
#'
#' @importFrom data.table as.data.table setkeyv
#' @export
splice_tabular <- function(main, secondary,
                            id.var = "id",
                            digits = 3,
                            col.names = NULL,
                            file = NULL,
                            align = NULL,
                            booktabs = TRUE,
                            standalone = FALSE,
                            caption = NULL,
                            label = NULL) {

  main      <- data.table::as.data.table(main)
  secondary <- data.table::as.data.table(secondary)

  if (!id.var %in% names(main))      stop("id.var '", id.var, "' not found in main")
  if (!id.var %in% names(secondary)) stop("id.var '", id.var, "' not found in secondary")

  value.cols <- setdiff(names(main), id.var)
  if (!setequal(value.cols, setdiff(names(secondary), id.var))) {
    stop("main and secondary must have the same non-id columns")
  }
  secondary <- secondary[, c(id.var, value.cols), with = FALSE]

  # align secondary rows to main rows by id (secondary need not be pre-sorted,
  # but every id in main must be present in secondary exactly once)
  data.table::setkeyv(secondary, id.var)
  if (anyDuplicated(secondary[[id.var]])) stop("secondary has duplicate ids")
  if (!all(main[[id.var]] %in% secondary[[id.var]])) {
    stop("every id in main must appear in secondary")
  }
  secondary <- secondary[match(main[[id.var]], secondary[[id.var]])]

  # resolve digits into a named vector over value.cols
  if (length(digits) == 1L && is.null(names(digits))) {
    digits <- stats::setNames(rep(digits, length(value.cols)), value.cols)
  } else {
    if (is.null(names(digits)) || !all(value.cols %in% names(digits))) {
      stop("digits must be a single number or a named vector/list covering all value columns")
    }
    digits <- unlist(digits)[value.cols]
  }

  fmt_num <- function(x, d) {
    ifelse(is.na(x), "", formatC(x, digits = d, format = "f"))
  }

  # escape LaTeX special characters in id labels (basic set)
  esc_latex <- function(x) {
    x <- as.character(x)
    x <- gsub("\\\\", "\\\\textbackslash{}", x)
    x <- gsub("([&%$#_{}])", "\\\\\\1", x)
    x <- gsub("\\^", "\\\\textasciicircum{}", x)
    x <- gsub("~", "\\\\textasciitilde{}", x)
    x
  }

  n <- nrow(main)
  body <- character(2L * n)

  for (i in seq_len(n)) {
    main_vals <- vapply(value.cols, function(cn) fmt_num(main[[cn]][i], digits[[cn]]),
                         character(1L))
    sec_vals  <- vapply(value.cols, function(cn) {
                   v <- fmt_num(secondary[[cn]][i], digits[[cn]])
                   if (v == "") "" else paste0("(", v, ")")
                 }, character(1L))

    id_label <- esc_latex(main[[id.var]][i])

    main_row <- paste(c(id_label, main_vals), collapse = " & ")
    sec_row  <- paste(c("",        sec_vals),  collapse = " & ")

    body[2L * i - 1L] <- paste0(main_row, " \\\\")
    body[2L * i]      <- paste0(sec_row,  " \\\\")
  }

  if (is.null(align)) {
    align <- paste0("l", paste(rep("r", length(value.cols)), collapse = ""))
  }

  if (is.null(col.names)) col.names <- value.cols
  if (length(col.names) != length(value.cols)) {
    stop("col.names must have length equal to the number of value columns")
  }
  header <- paste(c("", col.names), collapse = " & ")
  header_row <- paste0(header, " \\\\")

  top_rule <- if (booktabs) "\\toprule" else "\\hline"
  mid_rule <- if (booktabs) "\\midrule" else "\\hline"
  bot_rule <- if (booktabs) "\\bottomrule" else "\\hline"

  tabular_lines <- c(
    paste0("\\begin{tabular}{", align, "}"),
    top_rule,
    header_row,
    mid_rule,
    body,
    bot_rule,
    "\\end{tabular}"
  )

  if (standalone) {
    out <- c("\\begin{table}",
             if (!is.null(caption)) paste0("\\caption{", caption, "}"),
             if (!is.null(label))   paste0("\\label{", label, "}"),
             "\\centering",
             tabular_lines,
             "\\end{table}")
  } else {
    out <- tabular_lines
  }

  if (!is.null(file)) {
    writeLines(out, con = file)
  }

  invisible(out)
}
