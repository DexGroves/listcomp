parse_forif <- function(string, env) {
  if (is_for_clause(string)) {
    return(parse_for(string, env))
  }
  if (is_if_clause(string)) {
    return(parse_if(string, env))
  } else {
    stop(paste0("Invalid expression detected at:\t", string), call. = FALSE)
  }
}

parse_for <- function(string, env) {
  var_name <- str_extract(string, "(?<=for ).+?(?= in)")
  var_values_txt <- str_extract(string, "(?<= in ).+")
  var_values <- evaluate_expression_in_env(var_values_txt, env)

  sapply(var_values, new_env_with_value, var_name = var_name, parent = env)
}

parse_if <- function(string, env) {
  condition_txt <- str_extract(string, "(?<=^if ).+")
  condition_value <- evaluate_expression_in_env(condition_txt, env)
  if (!condition_value) {
    return(NULL)
  }
  env
}

new_env_with_value <- function(var_value, var_name, parent) {
  env <- new.env(parent = parent)
  assign(var_name, var_value, envir = env)
  env
}

evaluate_expression_in_env <- function(string, env) {
  eval(parse(text = string), envir = env)
}

usapply <- function(X, ...) {
  sapply(unlist(X), ...)
}
