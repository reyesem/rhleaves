# function: posrange
# description: computes a range of positive values, accounting for possibility
#              no positives exist.
posrange <- function(x) {
  if (!any(x)) {
    0
  } else {
    x |> which() |> range() |> diff()
  }
}



