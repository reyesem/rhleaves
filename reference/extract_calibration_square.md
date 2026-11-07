# Extract the calibration square as a pixset.

Isolates the area of an image containing a calibration square.

## Usage

``` r
extract_calibration_square(im, rmin = 0.8, gmax = 0.6, bmax = 0.6)
```

## Arguments

- im:

  a \`cimg\` object.

- rmin:

  minimum value of red spectrum (on scale of 0 to 1) for detecting the
  calibration square. Default = 0.8.

- gmax:

  maximum value of green spectrum (on scale of 0 to 1) for detecting the
  calibration square. Default = 0.6.

- bmax:

  maximum value of blue spectrum (on scale of 0 to 1) for detecting the
  calibration square. Default = 0.6.

## Value

a one-dimensional pixset corresponding to the calibration square.

## Details

The calibration square is detected as being the region with pixels such
that the RGB color value has an R value greater than \`rmin\`, a G value
less than \`gmax\`, and a B value less than \`bmax\`.
