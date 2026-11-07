# Extract the leaf component of an image.

Isolates the area of an image containing only the leaf, after removing
the given calibration square.

## Usage

``` r
extract_leaf_region(
  im,
  calibration_square,
  args.medianblur = list(n = 10, threshold = 0.5),
  args.threshold = list(thr = 0.8),
  args.clean = list(x = 25)
)
```

## Arguments

- im:

  a \`cimg\` object.

- calibration_square:

  one-dimensional pixset the same size as \`im\` that represents a
  calibration square area we know to ignore. If missing, assumed to be
  already removed from image.

- args.medianblur:

  named list of arguments to be passed to \[imager::medianblur()\].
  Default is \`list('n' = 10, 'threshold' = 0.5)\`.

- args.threshold:

  named list of arguments to be passed to \[imager::threshold()\].
  Default is \`list('thr' = 0.8)\`.

- args.clean:

  named list of arguments to be passed to \[imager::fill()\] and
  \[imager::clean()\]. Default is \`list('x' = 25)\`.

## Value

a one-dimensional pixset corresponding to the leaf region.

## Details

The image is converted to grayscale and a median filter is applied using
\[imager::medianblur()\] to create greater contrast between the leaf and
the background of the image. The darker pixels are assumed to belong to
the leaf and lighter pixels the background; a threshold is applied to
classify the pixels into the two regions using \[imager::threshold()\].
The pixset is then cleaned using \[imager::clean()\].
