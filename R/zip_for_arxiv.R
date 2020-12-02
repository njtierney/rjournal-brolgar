##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author Nicholas Tierney
##' @export
zip_for_arxiv <- function() {

  dir_create("arxiv")
  files_to_zip_all <- dir_ls(path = "paper/",
                         recurse = TRUE)
  
  files_to_zip <- str_subset(string = files_to_zip_all,
                             pattern = "morgue|html$|\\.R$",
                             negate = TRUE)
  zip(zipfile = "arxiv/arxiv-submission.zip",
      files = files_to_zip)

}
