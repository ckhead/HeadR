#' Stata-like linear interpolation with optional tail extrapolation
#'
#' @description
#' Fills missing values of `y` by linear interpolation over `x`, preserving
#' observed `y`. If `epolate = TRUE`, linearly extrapolates beyond the first
#' and last observed `x` using end slopes (mirrors Stata's `ipolate, epolate`).
#'
#' @param x Numeric vector used as the x-axis (e.g., year). Can be unsorted.
#' @param y Numeric vector (same length as `x`) to interpolate.
#' @param epolate Logical; if `TRUE`, apply linear tail extrapolation.
#'
#' @return A numeric vector the same length as `y`. Observed `y` are preserved;
#'   only NAs are filled (and only if there are ≥ 2 non-missing points).
#'
#' @examples
#' ## Example 1: Simple interior interpolation
#' x <- 2000:2005
#' y <- c(10, NA, 30, NA, NA, 60)
#' ipolate_stata(x, y)
#' # [1] 10 20 30 40 50 60
#'
#' ## Example 2: Missing at both ends
#' y2 <- c(NA, 20, NA, 40, NA, NA)
#' ipolate_stata(x, y2)
#' # [1] NA 20 30 40 NA NA
#' ipolate_stata(x, y2, epolate = TRUE)
#' # [1] 10 20 30 40 50 60
#'
#' ## Example 3: Only one non-missing value
#' y3 <- c(NA, NA, 50, NA, NA)
#' ipolate_stata(x[1:5], y3)
#' # [1] NA NA 50 NA NA  (returns original, no interpolation)
#'
#' ## Example 4: Unsorted x
#' x4 <- c(2003, 2001, 2002, 2005, 2004)
#' y4 <- c(30,   10,   NA,   60,   NA)
#' ipolate_stata(x4, y4)
#' # [1] 30 10 20 60 45  (restores original order after filling)
#'
#' @export
ipolate_stata <- function(x, y, epolate = FALSE) {
  stopifnot(length(x) == length(y))
  o  <- order(x)
  xs <- x[o]; ys <- y[o]
  
  keep <- !is.na(ys)
  if (sum(keep) < 2L) return(y)  # not enough info
  
  # Interior interpolation only (no extrapolation)
  yi <- approx(xs[keep], ys[keep], xout = xs, rule = 1L, ties = "mean")$y
  
  if (isTRUE(epolate)) {
    # Unique observed x's and corresponding y's for slope calc
    xu <- xs[keep]
    yu <- ys[keep]
    
    # For safety: reduce to strictly increasing x for slope computation
    # (average y at duplicate x)
    ord <- order(xu)
    xu <- xu[ord]; yu <- yu[ord]
    # collapse duplicates
    if (any(duplicated(xu))) {
      tapply_idx <- split(seq_along(xu), xu)
      xu <- as.numeric(names(tapply_idx))
      yu <- vapply(tapply_idx, function(ii) mean(yu[ii]), numeric(1))
      # ensure sorted again
      o2 <- order(xu)
      xu <- xu[o2]; yu <- yu[o2]
    }
    
    if (length(xu) >= 2L) {
      # Left tail: use first two points (x1,y1), (x2,y2)
      x1 <- xu[1]; y1 <- yu[1]
      x2 <- xu[2]; y2 <- yu[2]
      slope_L <- (y2 - y1) / (x2 - x1)
      
      left_idx <- which(xs < x1)
      if (length(left_idx)) {
        yi[left_idx] <- y1 + slope_L * (xs[left_idx] - x1)
      }
      
      # Right tail: use last two points (x_{n-1},y_{n-1}), (x_n,y_n)
      xn1 <- xu[length(xu) - 1L]; yn1 <- yu[length(yu) - 1L]
      xn  <- xu[length(xu)];       yn  <- yu[length(yu)]
      slope_R <- (yn - yn1) / (xn - xn1)
      
      right_idx <- which(xs > xn)
      if (length(right_idx)) {
        yi[right_idx] <- yn + slope_R * (xs[right_idx] - xn)
      }
    }
  }
  
  out <- y
  out[o] <- yi
  out
}