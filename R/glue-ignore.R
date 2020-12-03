glue_ignore <- function(x){
  glue::glue("\\.{x}$") %>% 
    glue::glue_collapse(sep = "|") %>% 
    as.character()
}
