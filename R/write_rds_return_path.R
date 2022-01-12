#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param x
#' @param file
#' @return
#' @author Nicholas Tierney
#' @export
write_rds_return_path <- function(x = heights_brolgar, file) {

  write_rds(
    x = x,
    file = file,
    compress = "xz"
  )
  
  return(
    here(file)
  )

}
