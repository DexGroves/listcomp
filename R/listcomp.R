#' Basic list comprehensions in R.
#'
#' Pass a Python-style list comprehension as a string and have it evaluated in
#' the calling environment.
#' Supports hopefully anything as long as its complexity is less than or equal
#' to: \cr
#'  `fn_a(item) for item in my_list if fn_b(item) == TRUE` \cr
#' and greater than or equal to: \cr
#'  `item for item in list` \cr
#' Does not support nesting.
#' @author Dex Groves
#' @param string text denoting the list comprehension to evaluate
#' @return evaluated list comprehension
#' @import stringr
#' @export
listcomp <- function(string) {
  target_obj <- get_target_object(string)
  item_name <- get_item_name(string)
  item_operation <- get_item_operation(string)
  lambda_cond <- get_item_conditional(string)

  lambda_fn <- get_item_operation_fn(item_operation, item_name)

  target_expr <- {
    sapply(get(target_obj), lambda_fn)
  }

  out <- eval(target_expr, enclos = parent.frame())

  if (is.na(lambda_cond)) {
    cond_vec <- TRUE
  } else {
    cond_fn <- get_item_operation_fn(lambda_cond, item_name)

    cond_expr <- {
      sapply(get(target_obj), cond_fn)
    }

    cond_vec <- eval(cond_expr, enclos = parent.frame())
  }

  out[cond_vec]
}
