##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param n_obs

##' @return
##' @author Nicholas Tierney
##' @export
prepare_heights <- function(n_obs_filter = 5) {

  heights_prep <- brolgar::heights %>% 
    filter(year > 1700) %>% 
    add_n_obs() %>% 
    filter(n_obs >= n_obs_filter) %>% 
    mutate(year0 = year - 1710)
  
  heights_prep

}
