# TODO - add a complete list of chords

#View(chords)
# TODO - Perhaps expand to a database.  Also could include
#      - Instruments (guitar, tuning)
#      - Tuning (standard strings)
#      - Chords - based on the above.
#      - create data frame of scales.
#      - Progressions I-IV-V, ii-V-I, etc

# TODO - refactor Make sure everything parameterized that should be
# TODO - other music related graphs:
#      - Manuscript, Piano keyboard, circle of fifths
# TODO - handle groups faceting
# TODO - warnings - fix or supress?
# options( warn = -1 )

#
#'Create guitar chord tablature chart.
#' @export
#' @param name The name of the chord
#' @param desc A vector with 6 elements representing strings.
#' A number indicates the fret and NA indicates a string
#' should not be played.
#' @param include_text Include tick mark labels on x and y axis.  Default is TRUE.
#' @param include_title Include the labels on the x and y axis. Default is TRUE.
#' @param x_labels A vector containing x tick mark labels.  Default is string numbers.
#' @param x_axis_label The x axis label.  Default is String.
#' @param dot_labels Adds labels in place of dots on frets.
#'
#' @examples
#' tablature('G Major', c(3, 2, 0, 0, 0, 3))
#'
#' B_M <- c(NA, 2, 4, 4, 4, 2)
#' tablature('B Major (bar)', B_M,
#'            x_labels=c(0,1,3,3,3,1),
#'            x_axis_label = 'Finger')
#'
#' tablature('B Major (bar)', B_M,
#'            dot_labels = c('','B','F#','B','D#','F#'))
#
tablature <-
 function(name,
          desc,
          include_text = TRUE,
          include_title = TRUE,
          x_labels=NULL,
          x_axis_label = 'String',
          dot_labels = NULL
          ) {

  # 6 strings, but we need to use rep to represent scales... mutliple
  # notes per string
  strings <- rep(seq(6,1,by=-1), length.out = length(desc))
  frets <- c(4, 3, 2, 1, 0)
  open_strings <- rep(0, length(desc))
  not_played_x <- (6:1)[which(is.na(desc))]
  not_played_y <- rep(0, length(not_played_x))

  if (is.null(x_labels)){
    x_labels <- strings
  }

  # Slide up the neck if needed.
  min_y <- 0
  if (min(desc, na.rm=TRUE) > 3) {
    min_y <- min(desc, na.rm=TRUE) - 1
    frets <- frets + min_y
  }

  desc <- as.numeric(sub(-0.5, 0, (desc - 0.5))) # Position finger before the fret.
  fret_positions <- tibble::tibble(strings, Fret = desc)

  p <- ggplot2::ggplot(fret_positions,
                       ggplot2::aes(x = strings,
                                    y = Fret)) + ggplot2::geom_point()

  if (!is.null(dot_labels)){
     p <- ggplot2::ggplot(fret_positions,ggplot2::aes(x=strings,
                                    y=Fret,
                                    label=c(dot_labels))) +
       ggplot2::geom_label(size = 2)
  }

  # Mark open strings
  p <- p  +
    ggplot2::geom_point(ggplot2::aes(x = strings,
                  y = open_strings),
              colour = 'white', alpha = 0.5) +
    ggplot2::theme(panel.grid.minor = ggplot2::element_blank()) +
    ggplot2::coord_fixed(ratio = 1.2)

# Add X for not played / muted strings
#  p <- p + geom_point(ggplot2::aes(x=not_played_x,
#                          y=not_played_y,
#                          shape=4, size=10)) +
#    scale_shape_identity()

  p <- p  +
    ggplot2::scale_y_reverse(breaks = frets,
                   labels = frets,
                   limits = c(max(frets), min_y)) +
    ggplot2::scale_x_reverse(breaks = strings,
                   labels = x_labels) +
    ggplot2::ggtitle(name)

  if (!include_text) {
   p <- p + ggplot2::theme(axis.text = ggplot2::element_blank(), axis.ticks = ggplot2::element_blank())
  }

  if (include_title) {
   p <- p + ggplot2::xlab(x_axis_label)
  }else{
   p <- p + ggplot2::theme(axis.title = ggplot2::element_blank())
  }

  p + ggplot2::theme(legend.position="none")
}


#' Chord for Frets
#'
#' Return the notes for a given set of frets for a specified tuning.
#' Preserves NAs indicating muted strings.
#' @export
#' @param frets A 6 element vector representing fret positions.
#' @param tuning A 6 element vector representing notes of open strings.
#'
#' @return Returns a 6 element vector of note names.
#'
#' @examples chord_for_frets(c(NA, 3, 2, 0, 1, 0))
#'
#' @seealso \code{\link{notes_for_frets}}
#'
chord_for_frets <- function(frets,
                            tuning=c('e','a','d','g','b','e')){
 notes<-rep(c('a','a#','b','c','c#','d','d#','e','f','f#','g','g#'),4)
 chord=c()
 for (i in 1:6){
  chord[i] <- notes[match(tuning[i], notes) + frets[i]]
 }
 chord
}

#
#' This function is similar to  \code{\link{chord_for_frets}} but
#' also handles scales.
#' Unlike chords_for_frets, this function removes NAs.
#' This means there are no muted strings identified
#' if a chord is passed in the frets argument.
#'
#' @export
#' @param frets A vector representing fret positions.
#' @param tuning A 6 element vector representing notes of open strings.
#' @return Returns a vector of note names.
#' @examples G_M_scale <- c(3, 0, 0, 0, NA, NA,
#'                         NA, 2, 2, NA, NA, NA,
#'                         NA, 3, 4, NA, NA, NA)
#' notes_for_frets(G_M_scale)
#'
#' @seealso \code{\link{chord_for_frets}}

notes_for_frets <- function(frets,
                            tuning=c('e','a','d','g','b','e')){
 notes<-rep(c('a','a#','b','c','c#','d','d#','e','f','f#','g','g#'),4)

 m <- matrix(frets, nrow=6)
 idx <- 0
 return_notes=rep(NA, length(frets))

 for (str in 1:nrow(m)){
  for (i in 1:ncol(m)){
   idx <- idx + 1
   offset <- m[str,i]
   if (length(offset) == 0){
    offset <- 0
   }
   return_notes[idx] <- notes[match(tuning[str], notes) + offset]
  }
 }

 return_notes[!is.na(return_notes)]

}

#' Narrow (Filter) Chord Selection
#'
#' This function filters rows in the chord data frame
#' by criteria passed in and accounts for nulls.
#' The nifty bit is - given a full set of chords, you can get chords that
#' use a given fret or frets.
#' @param chords A data frame of chords.
#' @param value The value to be filtered.
#' @param name The name to be filtered.
#' @return Returns a data frame of chords.
narrow_chord <- function(chords, value, name){
 if (!is.null(value) && value !=''){
  filter_expr <- paste(name, '==', value)
  chords <- dplyr::filter_(chords, filter_expr)
 }
 chords
}

#' Select chords by criteria
#'
#' @export
#' @param note_name Root of the chord.
#' @param chord_name Name of the chord.
#' @param string_1_fret Fret location on the 1st string.
#' @param string_2_fret Fret location on the 2nd string.
#' @param string_3_fret Fret location on the 3rd string.
#' @param string_4_fret Fret location on the 4th string.
#' @param string_5_fret Fret location on the 5th string.
#' @param string_6_fret Fret location on the 6th string.
#' @return Returns a data frame of chords.
#' @examples
#' select_chords(chord_name = 'Major', string_5_fret = 3)
#' select_chords(note='d')
select_chords <- function(
 note_name  = NULL,
 chord_name = NULL,
 string_1_fret = NULL,
 string_2_fret = NULL,
 string_3_fret = NULL,
 string_4_fret = NULL,
 string_5_fret = NULL,
 string_6_fret = NULL
 ){

 chord <- chords
 chord <- narrow_chord(chord, shQuote(chord_name), 'chord')
 chord <- narrow_chord(chord, shQuote(note_name), 'note')
 chord <- narrow_chord(chord, string_1_fret, 'string_1_fret')
 chord <- narrow_chord(chord, string_2_fret, 'string_2_fret')
 chord <- narrow_chord(chord, string_3_fret, 'string_3_fret')
 chord <- narrow_chord(chord, string_4_fret, 'string_4_fret')
 chord <- narrow_chord(chord, string_5_fret, 'string_5_fret')
 chord <- narrow_chord(chord, string_6_fret, 'string_6_fret')

 chord
}
