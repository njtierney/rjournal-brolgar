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
future::plan(future::multisession)

# pipeline ---------------------------------------------------------------------
tar_plan(
  heights_brolgar = prepare_heights(n_obs_filter = 5),
  heights_gam = fit_heights_gam(heights_brolgar),
  tar_target(heights_gam_rds, 
             write_rds_return_path(x = heights_gam,
                                   file = here("rds", 
                                               "heights_gam.rds"))),
  tar_target(heights_brolgar_rds, 
             write_rds_return_path(x = heights_brolgar,
                                   file = here("rds", 
                                               "heights_brolgar.rds"))),
  model_time = heights_gam$time_taken,
  tar_target(model_time_rds, 
             write_rds_return_path(x = model_time,
                                   file = here("rds", 
                                               "model_time.rds"))),
  # also need to add in a part that checks if a .bib file has been changed
  # perhaps using `tar_target(format = "file")`, 
  tar_target(paper_bib,
             "paper/brolgar-paper.bib",
             format = "file"),
  
  tar_render(name = report,
             path = "paper/brolgar-paper.Rmd"),
  
  tar_file(paper_path, 
           file.path("paper/brolgar-paper.Rmd")),
  
  tar_render(name = cover_letter,
             path = "cover-letter/cover-letter.Rmd"),
  
  tar_file(name = cover_letter_path,
           file.path("cover-letter/cover-letter.pdf")),
  
  tar_render(name = response,
             path = "reviewer-response/response.Rmd"),
  
  tar_file(name = response_path, 
           file.path("reviewer-response/response.pdf")),
  
  tar_file(rjournal_submission, {
    zip_for_rjournal(
      zipname = paper_path,
      zip_path = "rjournal/rjournal-submission.zip",
      cover_letter_path = cover_letter_path,
      response_path = response_path
    )
  }),
  
  tar_file(arxiv_submission, {
    zip_for_arxiv(
      x = paper_path,
      path = "arxiv/arxiv-submission.zip"
    )
  }
  )
)
