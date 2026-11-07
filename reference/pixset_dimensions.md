# Compute the length, width, and area of a pixset.

This computes the tallest column (length) of pixels in a pixset, the
widest row (width) of pixels in a pixset, and the total number of pixels
(area) of a pixset. Gaps are overlooked when counting the length and
width.

## Usage

``` r
pixset_dimensions(px)
```

## Arguments

- px:

  one-dimensional pixset.

## Value

a named vector of length 3 containing the length, width, and area.
