library(dplyr)

G_M <- c(3, 2, 0, 0, 0, 3)
C_M <- c(NA, 3, 2, 0, 1, 0)
D_M <- c(NA, NA, 0, 2, 3, 2)
C_M_bar <- c(8, 10, 10, 9, 8, 8)

context("Testing Chords")
test_that("Major chord matches notes", {

  expect_equal(chord_for_frets(C_M),
               c(NA,"c","e","g","c","e"))

  expect_equal(chord_for_frets(G_M),
               c("g","b","d","g","b","g"))

  expect_equal(chord_for_frets(D_M),
               c(NA,NA,"d","a","d","f#"))

  expect_equal(chord_for_frets(C_M_bar),
               c("c","g","c","e","g","c"))

})

test_that("Selected chords are correct", {

  df <- select_chords('g', 'Major') %>%
    dplyr::transmute(chord_name=paste(note, chord)) %>%
    dplyr::distinct()
  expect_equal(df$chord_name, 'g Major')
})

test_that("Selected chords include third fret", {
  df <- select_chords('g', 'Major', string_5_fret = 3)
  expect_equal(paste(df$note, df$chord), 'g Major')
  expect_equal(df$string_5_fret, 3)

  df <- select_chords(string_5_fret = 3)
  expect_equal(unique(df$string_5_fret), 3)
})
