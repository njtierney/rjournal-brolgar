##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param heights_brolgar
##' @return
##' @author Nicholas Tierney
##' @export
fit_heights_gam <- function(heights_brolgar) {

  start_time <- tic()
  heights_gam <- gam(
    height_cm ~ s(year0, by = country_fct) + country_fct,
    data = heights_brolgar,
    method = "REML"
  )
  end_time <- toc()
  
  total_time <- end_time$toc - end_time$tic
  
  return(list(model = heights_gam,
              time_taken = total_time))

}
