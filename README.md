
# rjournal-brolgar

<!-- badges: start -->
<!-- badges: end -->


# To recreate the paper

Use `targets` and `capsule` to recreate the paper.

- `targets` is the workflow system that ensures the steps required to complete the paper are completed in the right order. This is used as there is a computation (fitting many GAM models) that takes about 2-3 hours. 
- `capsule` locks in the R package versions, including where they were downloaded from (github or CRAN, for example), so that these can be locked in. Under the hood it uses Rstudio's `renv` R package.

To begin, we need to install `capsule`:

```r
# install.packages("remotes")
remotes::install_github("milesmcbain/capsule")
```

Then, we can get the R packages used with:

```r
capsule::reproduce_lib()
```

This recreates all of the R packages used in the analysis on your computer. Importantly, this will not change where your existing R packages are installed.

Then run:

```{r example, eval = FALSE}
capsule::run(targets::tar_make())
```

This runs our targets workflow using the R packages specified.

This will check if the targets are written (which they are, in the `_targets/objects` folder).