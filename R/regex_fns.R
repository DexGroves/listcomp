handle_square_brackets <- function(string) {
  if (str_detect(string, "^\\[") & str_detect(string, "\\]$")) {
    string <- str_replace(string, "^\\[", "")
    string <- str_replace(string, "\\]$", "")
  }
  string <- str_replace(string, "\\[", "lc(\"")
  str_replace(string, "\\]", "\")")
}

is_for_clause <- function(string) {
  str_detect(string, "^for")
}

is_if_clause <- function(string) {
  str_detect(string, "^if")
}
