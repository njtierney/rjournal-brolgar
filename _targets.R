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
  # also need to add in a part that checks if a .bib file has been changed
  # perhaps using `tar_target(format = "file")`, 
  tar_target(paper_bib,
             "paper/brolgar-paper.bib",
             format = "file"),
  tar_render(name = report,
             path = "paper/brolgar-paper.Rmd"),
  # ideally this would only run if the report has been rendered,
  # not sure how to detect that.
  tar_target(arxiv_paper,
             zip_for_arxiv()),
  tar_target(rjournal,
             zip_for_rjournal())
)
