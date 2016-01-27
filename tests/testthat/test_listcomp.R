my_list <- seq(10)


test_that("item for item in list", {
  expect_equal(my_list, lc('item for item in my_list'))
})

test_that("operation(item) for item in list", {
  expect_equal(my_list ^ 2, lc('item ^ 2 for item in my_list'))
})

test_that("item for item in list if condition", {
  expect_equal(
    my_list[my_list %% 2 == 0],
    lc('item for item in my_list if item %% 2 == 0'))
})

test_that("operation(item) for item in list if condition", {
  expect_equal(
    my_list[my_list %% 2 == 0] ^ 2,
    lc('item ^ 2 for item in my_list if item %% 2 == 0'))
})

test_that("simple nesting", {
  expect_equal(
    my_list,
    lc('item for item in [x for x in my_list]'))
})

test_that("unnecessary outer square brackets doesn't error", {
  expect_equal(
    my_list,
    lc('[item for item in [x for x in my_list]]'))
})

test_that("two sequential for clauses", {
  expect_equal(
    c(1,1,2,1,2,3,1,2,3,4,1,2,3,4,5),
    lc('y for x for x in seq(5) for y in seq(x)'))
})

test_that("three sequential for clauses", {
  expect_equal(
    c(1, 1, 1, 2, 1, 1, 2, 1, 2, 3),
    lc('z for x in seq(3) for y in seq(x) for z in seq(y)'))
})

test_that("fors and ifs sequentially", {
  expect_equal(
    c(1, 1, 2, 1, 2, 3, 1, 2, 3, 1, 2, 3),
    lc('y for x for x in seq(5) for y in seq(x) if y < 4'))
})

test_that("ifs interspersed with fors", {
  expect_equal(
    c(1, 1, 2, 1, 2, 3),
    lc('y for x for x in seq(5) if x < 4 for y in seq(x)'))
})

test_that("ifs, fors and nesting", {
  expect_equal(
    c(1, 1, 1, 2, 1, 1, 2, 1, 2, 3, 1, 1, 2, 1, 2, 3, 1, 2, 3, 4),
    lc('y for x in [a for b in seq(4) for a in seq(b)] for y in seq(x)'))
})
