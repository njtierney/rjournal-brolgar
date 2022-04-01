##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author Nicholas Tierney
##' @export
zip_for_arxiv <- function(x, path) {

  dir_create("arxiv")
  zip_name <- path
  files_to_zip_all <- dir_ls(dirname(x), recurse = TRUE)
  
  to_ignore <- glue_ignore(c("html", 
                             "R",
                             "Rmd",
                             "bib",
                             "aux",
                             "bldg",
                             "pdf",
                             "brf",
                             "out"))
  
  files_to_zip <- str_subset(string = files_to_zip_all,
                             pattern = paste0("morgue|",to_ignore),
                             negate = TRUE)
  
  if (file_exists(zip_name)) {
    file_delete(zip_name)
  }
  
  zip(zipfile = zip_name,
      files = files_to_zip)
  
  return(path)

}
