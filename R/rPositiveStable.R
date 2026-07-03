#' Draw from a Positive Stable Distribution
#'
#' @description Generates random draws from the positive (one-sided) stable distribution
#' with stability index \code{alpha}, denoted \eqn{PS(\alpha)}. This is the
#' law whose Laplace transform is the stretched exponential
#' \deqn{E[\exp(-s Z)] = \exp(-s^{\alpha}), \qquad s \ge 0,}
#' for \eqn{\alpha \in (0, 1]}. It is the mixing distribution that, combined
#' with an i.i.d. Gumbel shock, generates the nested logit model via the
#' Cardell (1997) decomposition: if \eqn{\eta} is standard Gumbel,
#' \eqn{Z \sim PS(\alpha)}, and the two are independent, then
#' \eqn{\alpha(\eta + \log Z)} is standard Gumbel.
#'
#' Draws are produced with the Chambers-Mallows-Stuck (1976) method for
#' one-sided stable variables, using two independent uniforms per draw.
#' The construction follows the algorithm given in the appendix of
#' Galichon (2026). The implementation is fully vectorized.
#'
#' @param nreps Integer. Number of draws to generate.
#' @param alpha Numeric scalar in \eqn{(0, 1]}. The stability index. Smaller
#'   values give heavier right tails; \code{alpha = 0.5} is the Levy
#'   distribution (Laplace transform \eqn{\exp(-\sqrt{2 s})}); \code{alpha = 1}
#'   is the degenerate point mass at 1.
#'
#' @return A numeric vector of length \code{nreps} containing strictly positive
#'   draws from \eqn{PS(\alpha)}.
#'
#' @details
#' The positive stable law has no closed-form density in general, so it is
#' most naturally characterized and simulated through its Laplace transform.
#' Because the distribution is heavy-tailed (its mean is infinite for
#' \eqn{\alpha < 1}), individual draws can be very large; this is expected
#' behavior, not a numerical error. Work with the draws on the log scale
#' (e.g. \code{log(Z)}) when feeding them into a Gumbel recombination.
#'
#' The generator can be validated by checking the defining Laplace transform:
#' for a vector of draws \code{Z} and any \code{s > 0}, the sample mean of
#' \code{exp(-s * Z)} should approximate \code{exp(-s^alpha)}.
#'
#' @references
#' Cardell, N. S. (1997). Variance Components Structures for the
#' Extreme-Value and Logistic Distributions with Application to Models of
#' Heterogeneity. \emph{Econometric Theory}, 13(2), 185-213.
#'
#' Chambers, J. M., Mallows, C. L., and Stuck, B. W. (1976). A Method for
#' Simulating Stable Random Variables. \emph{Journal of the American
#' Statistical Association}, 71(354), 340-344.
#'
#' Galichon, A. (2026). \emph{Discrete Choice Theory} (draft), Section 2.1.3
#' and Appendix A.2.3.
#'
#' @examples
#' # Draw from PS(0.5) and check the Laplace transform E[exp(-sZ)] = exp(-s^alpha)
#' set.seed(1)
#' Z <- rPositiveStable(1e5, alpha = 0.5)
#' s <- c(0.5, 1, 2)
#' rbind(
#'   empirical = sapply(s, function(si) mean(exp(-si * Z))),
#'   theoretical = exp(-s^0.5)
#' )
#'
#' # Cardell recombination: alpha*(Gumbel + log Z) is standard Gumbel
#' alpha <- 0.6
#' eta <- -log(-log(runif(1e5)))            # standard Gumbel
#' Z   <- rPositiveStable(1e5, alpha)
#' eps <- alpha * (eta + log(Z))            # should be standard Gumbel
#' c(mean = mean(eps), euler = 0.5772157)   # mean approx Euler's constant
#'
#' @export
rPositiveStable <- function(nreps, alpha) {
  if (length(alpha) != 1L || !is.finite(alpha) || alpha <= 0 || alpha > 1) {
    stop("'alpha' must be a single value in (0, 1].")
  }
  # Degenerate case: PS(1) is a point mass at 1 (Laplace transform exp(-s)).
  if (alpha == 1) {
    return(rep(1.0, nreps))
  }
  U <- runif(nreps)
  V <- runif(nreps)
  num1 <- sin((1 - alpha) * pi * U)
  den1 <- -log(V)
  num2 <- sin(alpha * pi * U)
  den2 <- sin(pi * U)^(1 / alpha)
  PS_draws <- ((num1 / den1)^((1 - alpha) / alpha)) * (num2 / den2)
  return(PS_draws)
}
