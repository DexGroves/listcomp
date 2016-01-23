get_target_object <- function(string) {
  if (contains_nesting(string)) {
    return(paste0("lc('", extract_nesting(string), "')"))
  }
  out <- str_extract(string, "(?<=in ).+?(\\z| (?=if))")
  str_replace(out, " ", "")
}

get_item_name <- function(string) {
  str_extract(remove_nesting(string), "[a-zA-Z0-9]+(?= in)")
}

get_item_operation <- function(string) {
  str_extract(remove_nesting(string), ".+(?= for)")
}

get_item_condition <- function(string) {
  str_extract(remove_nesting(string), "(?<=if ).+")
}

contains_nesting <- function(string) {
  str_detect(string, "\\[.+\\]")
}

extract_nesting <- function(string) {
  str_extract(string, "(?<=\\[).+(?=\\])")
}

remove_nesting <- function(string) {
  str_replace(string, "\\[.+\\]", "")
}
