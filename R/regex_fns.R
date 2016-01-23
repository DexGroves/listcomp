get_target_object <- function(string) {
  out <- str_extract(string, "(?<=in ).+?(\\z| (?=if))")
  str_replace(out, " ", "")
}

get_item_name <- function(string) {
  str_extract(string, "[a-zA-Z0-9]+(?= in)")
}

get_item_operation <- function(string) {
  str_extract(string, ".+(?= for)")
}

get_item_condition <- function(string) {
  str_extract(string, "(?<=if ).+")
}
