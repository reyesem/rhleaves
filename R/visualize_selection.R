#' Visualize selection.
#'
#' Highlights a selection (like the calibration square or the leaf) on a
#' grayscale version of the image. This is a quick way of verifying the settings
#' for isolating the region.
#'
#' @param im a `cimg` object.
#' @param region pixset representing the region selected.
#' @param color color to highlight (default = 'green').
#'
#' @returns a plot object.
#'
#' @export

plot_selection <- function(im, region, color = 'green') {

  #plot region
  imager::colorise(
    im |> imager::grayscale(),
    region,
    color,
    alpha = 0.5
  ) |>
    plot()
}
