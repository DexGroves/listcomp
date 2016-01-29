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

parse_square_brackets <- function(string) {
  string <- handle_outer_squares(string)

  words <- str_split(string, " ")[[1]]

  i <- 1
  clauses <- c()
  last_clause <- 1

  while (i < length(words)) {
    if (str_detect(words[i], "^\\[")) {
      end_squares <- i + wait_out_squares(words[i:length(words)])
      words[i] <- str_replace(words[i], "^\\[", "lc\\(\"")
      words[end_squares] <- str_replace(words[end_squares], "\\]$", "\"\\)")
      i <- end_squares
    }
    i <- i + 1
  }

  paste(words, collapse = " ")
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

wait_out_squares <- function(words) {
  lbracket_count <- 0
  rbracket_count <- 0
  for (j in 1:length(words)) {
    lbracket_count <- lbracket_count + str_count(words[j], "\\[")
    rbracket_count <- rbracket_count + str_count(words[j], "\\]")
    if (lbracket_count == rbracket_count) {
      break
    }
  }
  j - 1
}
