#' Guess plot dimensions.
#'
#' @param x A dataframe; a ForestGEO dataset (census or ViewFullTable).
#' @param accuracy A number giving the accuracy with which to round `gx` and
#'   `gy`.
#'
#' @return A numeric vector of length 2.
#' @export
#'
#' @family functions for fgeo census and vft.
#' @family functions for fgeo census.
#' @family functions for fgeo vft.
#' @family general functions to find or approximate
#'
#' @examples
#' x <- data.frame(
#'   gx = c(0, 300, 979),
#'   gy = c(0, 300, 481)
#' )
#' guess_plotdim(x)
guess_plotdim <- function(x, accuracy = 20) {
  stopifnot(is.data.frame(x))
  stopifnot(is.numeric(accuracy))

  names(x) <- tolower(names(x))
  .match <- c("x", "gx", "y", "gy", "x", "px")
  matched <- nms_pull_matches(x, .match)

  n_nms <- length(matched)
  if (n_nms != 2) {
    stop("Not enough columns to find x/y positions.\n", matched, call. = FALSE)
  }

  guess <- vapply(
    x[ , c("gx", "gy")], guess_max, double(1), accuracy = accuracy
  )

  message("Gessing: plotdim = c(", glue_comma(guess), ")")
  unname(guess)
}

#' Guess maximum value of a vector with flexible accuracy.
#'
#' @param x Numeric vector.
#' @param accuracy A single number.
#'
#' @family general functions to find or approximate
#'
#' @return A number.
#' @export
#'
#' @examples
#' guess_max(1:19, 20)
guess_max <- function(x, accuracy) {
  max_x <- max(x, na.rm = TRUE)
  round_any(max_x, f = ceiling, accuracy = accuracy)
}

#' Round to multiple of any number. Copied from `plyr:::round_any.numeric()`.
#'
#' @param x Numeric vector to round.
#' @param accuracy Number to round to.
#' @param f Rounding function: floor, ceiling or round.
#'
#' @seealso `plyr::round_any()` and \url{http://bit.ly/2JrBQK3}.
#' @family functions for developers
#' @family functions dealing with names.
#' @family functions for developers with no dependencies.
#' @family general functions to find or approximate
#'
#' @export
#'
#' @examples
#' # From pryr::round_any()
#' round_any(135, 10)
#' round_any(135, 100)
#' round_any(135, 25)
#' round_any(135, 10, floor)
#' round_any(135, 100, floor)
#' round_any(135, 25, floor)
#' round_any(135, 10, ceiling)
#' round_any(135, 100, ceiling)
#' round_any(135, 25, ceiling)
round_any <- function(x, accuracy, f = round) {
  f(x / accuracy) * accuracy
}



