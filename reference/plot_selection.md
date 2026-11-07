# Visualize selection.

Highlights a selection (like the calibration square or the leaf) on a
grayscale version of the image. This is a quick way of verifying the
settings for isolating the region.

## Usage

``` r
plot_selection(im, region, color = "green")
```

## Arguments

- im:

  a \`cimg\` object.

- region:

  pixset representing the region selected.

- color:

  color to highlight (default = 'green').

## Value

a plot object.
