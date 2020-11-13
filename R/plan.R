the_plan <-
  drake_plan(
    
    heights_brolgar = prepare_heights(n_obs_filter = 5),
    heights_gam = fit_heights_gam(heights_brolgar),
    write_gam = readr::write_rds(x = heights_gam, 
                                 file = here::here("paper/heights_gam.rds"),
                                 compress = "xz")

    # paper = target(
    #   command = {
    #     rmarkdown::render(knitr_in("paper/brolgar-paper.Rmd"))
    #     file_out("paper/brolgar-paper.html")
    #     file_out("paper/brolgar-paper.R")
    #   }
    # )

)
