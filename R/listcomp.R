#' Basic list comprehensions in R.
#'
#' Pass a Python-style list comprehension as a string and have it evaluated in
#' the calling environment.
#' Supports hopefully anything with complexity less than or equal to: \cr
#'  `fn_a(item) for item in my_list if fn_b(item) == TRUE` \cr
#' and greater than or equal to: \cr
#'  `item for item in list` \cr
#' Supports nesting by wrapping inner comprehensions with `[]`.
#' @author Dex Groves
#' @param string text denoting the list comprehension to evaluate
#' @return evaluated list comprehension
#' @import stringr
#' @export
#' @examples
#' my_list <- seq(10)
#' nested_list <- list(seq(5), seq(10))
#' lc('item ^ 2 for item in my_list if item %% 2 == 0')
#' lc('x ^ 2 for x in [max(y) for y in nested_list]')
lc <- function(string) {
  target_obj <- get_target_object(string)
  item_name <- get_item_name(string)
  item_operation <- get_item_operation(string)
  item_condition <- get_item_condition(string)

  if (is.na(target_obj) | is.na(item_name) | is.na(item_operation)) {
    stop("Invalid comprehension!", call. = FALSE)
  }

  lambda_fn <- get_item_operation_fn(item_operation, item_name)

  target_expr <- {
    sapply(eval.parent(parse(text = target_obj)), lambda_fn)
  }

  out <- eval(target_expr, enclos = parent.frame())

  if (is.na(item_condition)) {
    cond_vec <- TRUE
  } else {
    cond_fn <- get_item_operation_fn(item_condition, item_name)

    cond_expr <- {
      sapply(eval.parent(parse(text = target_obj)), cond_fn)
    }

    cond_vec <- eval(cond_expr, enclos = parent.frame())
  }

  out[cond_vec]
}

listcomp <- lc
