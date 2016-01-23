get_item_operation_fn <- function(operation, varname) {
  output_fn <- function(x) {
    eval(parse(text = eval(operation)))
  }
  output_formals <- list(NA)
  names(output_formals) <- varname

  formals(output_fn) <- output_formals
  output_fn
}
