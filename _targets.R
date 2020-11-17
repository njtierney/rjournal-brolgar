library(targets)
library(tarchetypes)
options(tidyverse.quiet = TRUE,
        future.supportsMulticore.unstable = "quiet")
## Load your R files
source("tar-option-set.R")
fs::dir_walk(path = "R/", fun = source)
source("conflicts.R")

# --- things for future and clusters -----------------
# Uncomment below to use local multicore computing
# when running tar_make_clustermq().
options(clustermq.scheduler = "multicore")

# Uncomment below to deploy targets to parallel jobs
# on a Sun Grid Engine cluster when running tar_make_clustermq().
# options(clustermq.scheduler = "sge", clustermq.template = "sge.tmpl")
future::plan(future::multiprocess)

# pipeline ---------------------------------------------------------------------
tar_pipeline(
  tar_target(heights_brolgar,
             prepare_heights(n_obs_filter = 5)),
  tar_target(heights_gam,
             fit_heights_gam(heights_brolgar)),
  tar_target(model_time,
             heights_gam$time_taken),
  tar_render(name = report,
             path = "paper/brolgar-paper.Rmd")
)
