parse_clauses <- function(string) {
  words <- str_split(string, " ")[[1]]

  i <- 1
  clauses <- c()
  last_clause <- 1

  while (i < length(words)) {
    if (words[i] %in% c("for", "if")) {
      clauses <- c(clauses,
                   paste(words[last_clause:(i - 1)], collapse = " "))
      last_clause <- i
    } else if (str_detect(words[i], "\\(")) {
      i <- i + wait_out_brackets(words[i:length(words)])
    }
    i <- i + 1
  }
  clauses <- c(clauses,
               paste(words[last_clause:length(words)], collapse = " "))
  clauses
}

wait_out_brackets <- function(words) {
  lbracket_count <- 0
  rbracket_count <- 0
  for (j in 1:length(words)) {
    lbracket_count <- lbracket_count + str_count(words[j], "\\(")
    rbracket_count <- rbracket_count + str_count(words[j], "\\)")
    if (lbracket_count == rbracket_count) {
      break
    }
  }
  j - 1
}
