my_list <- seq(10)

test_that("item for item in list works", {
  expect_equal(my_list, listcomp('item for item in my_list'))
})

test_that("operation(item) for item in list works", {
  expect_equal(my_list ^ 2, listcomp('item ^ 2 for item in my_list'))
})

test_that("item for item in list if condition works", {
  expect_equal(my_list[my_list %% 2 == 0],
               listcomp('item for item in my_list if item %% 2 == 0'))
})

test_that("operation(item) for item in list if condition works", {
  expect_equal(my_list[my_list %% 2 == 0] ^ 2,
               listcomp('item ^ 2 for item in my_list if item %% 2 == 0'))
})

test_that("simple nesting works", {
  expect_equal(my_list,
               listcomp('item for item in [x for x in my_list]'))
})

