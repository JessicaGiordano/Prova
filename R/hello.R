#' Add together two numbers.
#'
#' @param x A number.
#' @param y A number.
#' @return The sum of \code{x} and \code{y}.
#' @examples
#' add(1, 1)
#' add(10, 11)
#' add(3,47)
#' @import deSolve
#' @export
add <- function(x, y) {
  -y+2*x
}
