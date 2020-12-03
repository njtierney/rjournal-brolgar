##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author Nicholas Tierney
##' @export
zip_for_rjournal <- function() {

  dir_create("rjournal")
  zip_name <- "rjournal/rjournal-submission.zip"
  files_to_zip_all <- dir_ls(path = "paper/",
                             recurse = TRUE)
  
  cover_letter <- dir_ls(path = "cover-letter",
                         regexp = "cover-letter.pdf$")
  
  to_ignore <- glue_ignore(c("html", 
                             "aux",
                             "bbl",
                             "blg",
                             "sty",
                             "bldg",
                             "brf",
                             "out"))
  
  files_to_zip <- str_subset(string = c(files_to_zip_all,
                                        cover_letter),
                             pattern = paste0("morgue|",to_ignore),
                             negate = TRUE)
  
  if (file_exists(zip_name)) {
    file_delete(zip_name)
  }
  
  zip(zipfile = zip_name,
      files = files_to_zip)
  

}
