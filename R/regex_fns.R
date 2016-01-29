handle_outer_squares <- function(string) {
  if (str_detect(string, "^\\[") & str_detect(string, "\\]$")) {
    string <- str_replace(string, "^\\[", "")
    string <- str_replace(string, "\\]$", "")
  }
  string
}

is_for_clause <- function(string) {
  str_detect(string, "^for")
}

is_if_clause <- function(string) {
  str_detect(string, "^if")
}
