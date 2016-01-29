context("Basic data.frame operations")

library("ggplot2")
data(diamonds)


test_that("1xN operations", {
  lc_diamond_means <- lc('mean(x) for x in diamonds if is.numeric(x)')
  true_diamond_means <- sapply(diamonds[, sapply(diamonds, is.numeric)], mean)

  expect_equal(lc_diamond_means, true_diamond_means)
  expect_equal(names(lc_diamond_means), names(true_diamond_means))
})

test_that("MxN operations", {
  lc_diamond_head <- lc('head(x) for x in diamonds if is.numeric(x)')
  lc_diamond_head <- sapply(lc_diamond_head, function(x) x)
  true_diamond_head <- sapply(diamonds[, sapply(diamonds, is.numeric)], head)

  expect_equal(lc_diamond_head, true_diamond_head)
  expect_equal(names(lc_diamond_head), names(true_diamond_head))
})
