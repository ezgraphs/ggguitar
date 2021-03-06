#' A dataset containing chords.
#'
#' A dataset containing chords, their location
#' on a guitar neck, and the standard fingering used
#' to play them.
#'
#' @format A data frame chords:
#' \describe{
#'   \item{X1}{id field}
#'   \item{note}{note that is the root of the chord}
#'   \item{chord}{name of the chord}
#'   \item{string_1_fret}{Which fret should be pressed on the first string.}
#'   \item{string_2_fret}{Which fret should be pressed on the second string.}
#'   \item{string_3_fret}{Which fret should be pressed on the third string.}
#'   \item{string_4_fret}{Which fret should be pressed on the fourth string.}
#'   \item{string_5_fret}{Which fret should be pressed on the fifth string.}
#'   \item{string_6_fret}{Which fret should be pressed on the sixth string.}
#'   \item{string_1_finger}{Which finger should press the specified fret on the first string.}
#'   \item{string_2_finger}{Which finger should press the specified fret on the second string.}
#'   \item{string_3_finger}{Which finger should press the specified fret on the third string.}
#'   \item{string_4_finger}{Which finger should press the specified fret on the fourth string.}
#'   \item{string_5_finger}{Which finger should press the specified fret on the fifth string.}
#'   \item{string_6_finger}{Which finger should press the specified fret on the sixth string.}
#' }
"chords"
