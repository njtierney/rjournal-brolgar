
# rjournal-brolgar

<!-- badges: start -->
<!-- badges: end -->


# To recreate the paper

Use `targets` and `capsule` to recreate the paper.

You can install `capsule` with:

```r
# install.packages("remotes")
remotes::install_github("milesmcbain/capsule")
```

Get the R packages used with:

```r
capsule::reproduce_lib()
```


Then run

```{r example, eval = FALSE}
capsule::run(targets::tar_make())
```

This will generate the paper.

