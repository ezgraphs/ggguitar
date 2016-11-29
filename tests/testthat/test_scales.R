context("Testing Scales")

G_M_scale <- c(3, 0, 0, 0, NA, NA,
               NA, 2, 2, NA, NA, NA,
               NA, 3, 4, NA, NA, NA)

C_M_scale <- c(NA, NA, 0, 0, 0, NA,
               NA, NA, 2, 2, 1, NA,
               NA, 3, 3, NA, NA, NA)

test_that("Major scale matches notes", {
  expect_equal(notes_for_frets(G_M_scale),
               c("g", "a", "b", "c", "d", "e", "f#", "g"))

  expect_equal(notes_for_frets(C_M_scale),
               c("c", "d", "e", "f", "g", "a", "b", "c"))
})
