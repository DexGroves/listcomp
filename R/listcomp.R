#' Basic list comprehensions in R.
#'
#' Pass a Python-style list comprehension as a string and have it evaluated in
#' the calling environment.
#' Supports nesting by wrapping inner comprehensions with `[]`.
#' @author Dex Groves
#' @param string text denoting the list comprehension to evaluate
#' @return evaluated list comprehension
#' @import stringr
#' @export
#' @examples
#' my_sequence <- seq(10)
#' nested_list <- list(seq(5), seq(10))
#' lc('item ^ 2 for item in my_sequence if item %% 2 == 0')
#' lc('x ^ 2 for x in [max(y) for y in nested_list]')
#' lc("j for i in seq(5) if i > 3 for j in seq(i)")
#'
#' library("ggplot2")
#' data(diamonds)
#' lc('mean(x) for x in diamonds if is.numeric(x)')
lc <- function(string) {
  string <- handle_square_brackets(string)
  clauses <- parse_clauses(string)
  left_expr <- clauses[1]
  forif_exprs <- clauses[2:length(clauses)]

  all_environments <- c(new.env(parent = parent.frame()))
  for (forif_expr in forif_exprs) {
    all_environments <- usapply(all_environments, parse_forif,
                                string = forif_expr)
  }

  usapply(all_environments, evaluate_expression_in_env, string = left_expr)
}

listcomp <- lc
