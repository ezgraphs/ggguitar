# library(ggplot2)
# library(dplyr)
# library(tibble)
# library(gridExtra)
# library(readr)
# # TODO Maybe make a vigenette based on the examples ???
# G_M <- c(3, 2, 0, 0, 0, 3)
#
# B_M <- c(NA, 2, 4, 4, 4, 2)
# C_M <- c(NA, 3, 2, 0, 1, 0)
# C_M <- c(NA, 3, 2, 0, 1, 0)
# C_M_bar <- c(8, 10, 10, 9, 8, 8)
# D_M <- c(NA, NA, 0, 2, 3, 2)
# F_M7 <- c(NA, NA, 3, 2, 1, 0)
#
# e_m <- c(0, 2, 2, 0, 0, 0)
# a_m <- c(NA, 0, 2, 2, 1, 0)
# b_m <- c(NA, 2, 4, 4, 3, 2)
#
# G_Major <- tablature('G Major', G_M)
# C_Major <- tablature('C Major', C_M, TRUE, FALSE)
# D_Major <- tablature('D Major', D_M, FALSE, FALSE)
# e_minor <- tablature('e minor', e_m)
# a_minor <- tablature('a minor', a_m, TRUE, FALSE)
# b_minor <- tablature('b minor', b_m)
#
# B_Major <- tablature('B Major (bar)', B_M,
#                      x_labels=c(0,1,3,3,3,1),
#                      x_axis_label = 'Finger'
# )
# B_Major_notes <- tablature('B Major (bar)', B_M,
#                            x_labels=c('','B','F#','B','D#','F#'),
#                            x_axis_label = 'Notes'
# )
# B_Major_note_labels <- tablature('B Major (bar)', B_M,
#                                  x_labels=c(0,1,3,3,3,1),
#                                  x_axis_label = 'Finger',
#                                  dot_labels = c('','B','F#','B','D#','F#')
# )
#
# C_Major_bar <- tablature('C Major (bar)', C_M_bar, TRUE, FALSE)
#
# F_Major_7 <- tablature('F Major 7', F_M7,
#                        x_labels=c(0,0,4,3,2,0),
#                        x_axis_label = 'Finger'
# )
#
# e_m_add9 <- c(0,2,4,0,0,0)
# e_minor_add9 <- tablature('e minor add 9', e_m_add9)
#
# grid.arrange(G_Major, C_Major, D_Major,
#              a_minor, b_minor,
#              B_Major, B_Major_notes, B_Major_note_labels,
#              F_Major_7, C_Major_bar,
#              e_minor, e_minor_add9,
#              ncol = 4)
#
# select_chords('c', 'Major add 9', string_5_fret = 3) %>%
#   filter(row_number()==1) %>%
#   select(matches('fret')) %>%
#   t() %>% as.vector() %>%
#   notes_for_frets()
#
#
# G_M_scale <- c(3, 0,0,0,NA,NA,
#                NA,2,2,NA,NA,NA,
#                NA,3,4,NA,NA,NA)
#
# tablature('G Major Scale', G_M_scale,
#           dot_labels=c(2, 0,0,0,NA,NA,
#                        NA, 1,1,NA,NA,NA,
#                        NA, 2,3,NA,NA,NA))
#
#
# # df <- chords %>% filter(chord=='Major')
# # x <- list()
# # by(df, 1:nrow(df), function(row){
# #   desc <- row %>% select(matches('fret')) %>% t() %>% as.vector()
# #   x<-c(x, tablature(paste(row$note, row$chord), desc))
# # })
# #
# #
# # grid.arrange(x)
# # grid.arrange(x, ncol=3)
#
# tablature('C Major', C_M, TRUE, TRUE)
# tablature('C Major', C_M, TRUE, FALSE) # Remove axis titles
# tablature('C Major', C_M, FALSE, FALSE) # Remove axis labels
#
#
