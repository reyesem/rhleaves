#' Extract the calibration square as a pixset.
#'
#' Isolates the area of an image containing a calibration square.
#'
#' The calibration square is detected as being the region with pixels such that
#' the RGB color value has an R value greater than `rmin`, a G value less than
#' `gmax`, and a B value less than `bmax`.
#'
#'
#' @param im a `cimg` object.
#' @param rmin minimum value of red spectrum (on scale of 0 to 1) for
#' detecting the calibration square. Default = 0.8.
#' @param gmax maximum value of green spectrum (on scale of 0 to 1) for
#' detecting the calibration square. Default = 0.6.
#' @param bmax maximum value of blue spectrum (on scale of 0 to 1) for
#' detecting the calibration square.  Default = 0.6.
#'
#' @returns a one-dimensional pixset corresponding to the calibration square.
#'
#' @export

extract_calibration_square <- function(im,
                                      rmin,
                                      gmax,
                                      bmax) {

  #RGB values must be in interval (0, 1)
  if (rmin < 0 || rmin > 1 || gmax < 0 || gmax > 1 || bmax < 0 || bmax > 1) {
    stop('RGB values must be between 0 and 1.')
  }


  #isolate calibration square
  (imager::R(im) > rmin) & (imager::G(im) < gmax) & (imager::B(im) < bmax)
}


#' Extract the leaf component of an image.
#'
#' Isolates the area of an image containing only the leaf, after removing the
#' given calibration square.
#'
#' The image is converted to grayscale and a median filter is applied using
#' [imager::medianblur()] to create greater contrast between the leaf and the
#' background of the image.  The darker pixels are assumed to belong to the leaf
#' and lighter pixels the background; a threshold is applied to classify the
#' pixels into the two regions using [imager::threshold()].  The pixset is then
#' cleaned using [imager::clean()].
#'
#'
#' @param im a `cimg` object.
#' @param calibration_square one-dimensional pixset the same size as `im` that
#' represents a calibration square area we know to ignore.
#' @param args.medianblur named list of arguments to be passed to
#' [imager::medianblur()]. Default is `list('n' = 10, 'threshold' = 0.5)`.
#' @param args.threshold named list of arguments to be passed to
#' [imager::threshold()]. Default is `list('thr' = 0.8)`.
#' @param args.clean named list of arguments to be passed to [imager::fill()]
#' and [imager::clean()]. Default is `list('x' = 25)`.
#'
#' @returns a one-dimensional pixset corresponding to the leaf region.
#'
#' @export

extract_leaf_region <- function(
    im,
    calibration_square,
    args.medianblur = list('n' = 10, 'threshold' = 0.5),
    args.threshold = list('thr' = 0.8),
    args.clean = list('x' = 25)) {

  onlyleaf <- im |> imager::grayscale()
  onlyleaf[calibration_square] <- 1

  onlyleaf <- do.call(imager::medianblur,
                      args = c(list('im' = onlyleaf), args.medianblur))

  onlyleaf <- do.call(imager::threshold,
                      args = c(list('im' = onlyleaf), args.threshold))

  onlyleaf <- !onlyleaf

  onlyleaf <- do.call(imager::clean,
                      args = c(list('im' = onlyleaf), args.clean))

  onlyleaf <- do.call(imager::fill,
                      args = c(list('im' = onlyleaf), args.clean))
}


#' Compute the length, width, and area of a pixset.
#'
#' This computes the tallest column (length) of pixels in a pixset, the widest
#' row (width) of pixels in a pixset, and the total number of pixels (area) of
#' a pixset. Gaps are overlooked when counting the length and width.
#'
#' @param px one-dimensional pixset.
#'
#' @returns a named vector of length 3 containing the length, width, and area.
#'
#' @export

pixset_dimensions <- function(px) {
  pxlength <- px |>
    apply(1, posrange) |>
    max()

  pxwidth <- px |>
    apply(2, posrange) |>
    max()

  pxarea <- sum(px)

  c('length' = pxlength,
    'width' = pxwidth,
    'area' = pxarea)
}

