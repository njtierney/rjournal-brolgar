##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author Nicholas Tierney
##' @export
zip_for_rjournal <- function(zipname, zip_path, cover_letter_path, response_path) {

  dir_create("rjournal")
  zip_name <- zip_path
  files_to_zip_all <- dir_ls(dirname(zipname), recurse = TRUE)
  
  to_ignore <- glue_ignore(c("aux",
                             "bbl",
                             "blg",
                             "sty",
                             "bldg",
                             "brf",
                             "out"))
  
  files_to_zip <- str_subset(string = c(files_to_zip_all,
                                        cover_letter_path,
                                        response_path),
                             pattern = paste0("morgue|",to_ignore),
                             negate = TRUE)
  
  zip(zipfile = zip_name,
      files = files_to_zip)
  
  return(zip_path)
  

}
