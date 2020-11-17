
# brolgar: An R package to BRowse Over Longitudinal Data Graphically and Analytically in R

(To be submitted to the R Journal)

<!-- badges: start -->
<!-- badges: end -->


# To recreate the paper

Use `targets` and `capsule` to recreate the paper.

- `targets` is the workflow system that ensures the steps required to complete the paper are completed in the right order. This is used as there is a computation (fitting many GAM models) that takes about 2-3 hours. 
- `capsule` locks in the R package versions, including where they were downloaded from (github or CRAN, for example), so that these can be locked in. Under the hood it uses Rstudio's `renv` R package.

There are three steps to reproduce the paper

## Step 1: Install `capsule`

```r
# install.packages("remotes")
remotes::install_github("milesmcbain/capsule")
```

## Step 2: Reproduce the libraries used 

```r
capsule::reproduce_lib()
```

This recreates all of the R packages used in the analysis on your computer. Importantly, this will not change where your existing R packages are installed. It is just for this repository. So no need to be concerned about this impacting other analyses you run.

## Step 3: Run the target workflow

```r
capsule::run(targets::tar_make())
```

This runs our targets workflow using the R packages specified.

This will check if the targets are written, and if they aren't, it will re-run the necessary ones. In this case, the targets are stored in the `_targets/objects` folder, so the paper should just be created - it will be in `paper/brolgar-paper.html` or `paper/brolgar-paper.pdf`.

## Step 4 - ?

Make some changes to the paper and want to see them? Run the capsule again:

```r
capsule::run(targets::tar_make())
```

And the paper will be recreated.