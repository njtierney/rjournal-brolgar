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

  gam_heights <- heights_brolgar %>% 
    mutate(country_fct = factor(country)) %>% 
    gam(height_cm ~ s(year0, by = country_fct) + country_fct, 
        data = .,
        method = "REML")

}
