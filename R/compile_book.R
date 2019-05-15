# Detect proper script_path (you cannot use args yet as they are build with tools in set_env.r)
script_path <- (function() {
  args <- commandArgs(trailingOnly = FALSE)
  script_path <- dirname(sub("--file=", "", args[grep("--file=", args)]))
  if (!length(script_path)) {
    return("R")
  }
  if (grepl("darwin", R.version$os)) {
    base <- gsub("~\\+~", " ", base) # on MacOS ~+~ in path denotes whitespace
  }
  return(normalizePath(script_path))
})()

# Setting .libPaths() to point to libs folder
source(file.path(script_path, "set_env.R"), chdir = T)

config <- load_config()
args <- args_parser()

###############################################################################


# load libraries
library(ml.core)

source("R/set_folders.R")

# book_src_dir <- file.path(project_root, "work", "book1")

loginfo("--> Pandoc version: %s", rmarkdown::pandoc_version())
# change to directory where RMD files are
setwd(book_src_dir)
logdebug(book_src_dir)


if (file.exists("_main.Rmd") || (file.exists("_main.md")))  {
  file.remove("_main.Rmd")
  file.remove("_main.md")
}

# remove the _bookdown_files folder to enable again building the book
# otherwise it will give error at the next notebook
if (dir.exists("_bookdown_files")) {
  loginfo("removing folder")
  unlink("_bookdown_files", recursive = TRUE, force = TRUE)
}

if (dir.exists("_book")) {
  loginfo("removing folder")
  unlink("_book", recursive = TRUE, force = TRUE)
}

logdebug(book_out_dir)

# build the book
# rmarkdown::render_site(
#                       encoding = 'UTF-8'
#                       # output_format = "bookdown::pdf_book"
#                       )

# render PDF
# rmarkdown::render_site(output_format = 'bookdown::pdf_book', encoding = 'UTF-8')

# function to print RMD files
knit_rmd <- function() {
  # rmarkdown::render_site(output_format = 'bookdown::gitbook', encoding = 'UTF-8')
  rmarkdown::render_site(encoding = 'UTF-8')
}


selection <- list(
  regre_101 = list(yaml = "_bookdown_regression_101.yml"),
  regre_202 = list(yaml = "_bookdown_regression_202.yml"),
  class_101 = list(yaml = "_bookdown_classification_101.yml"),
  class_202 = list(yaml = "_bookdown_classification_202.yml"),
  comp = list(yaml = "_bookdown_comparison.yml"),
  meta = list(yaml = "_bookdown_meta.yml"),
  misc = list(yaml = "_bookdown_misc.yml"),
  custom = list(yaml = "_bookdown_custom.yml")
)

# function to handle what to do with the arguments
kniter <- function(which) {
  unlink("_bookdown_files", recursive = TRUE, force = TRUE) # remove folder
  if (which == "all") {
    knit_rmd()  # do not change anything
  }  else if (which == "regre") {
    file.copy("_bookdown.yml", "_bookdown.yml.bak", overwrite = TRUE)
    file.copy("_bookdown_regression.yml", "_bookdown.yml", overwrite = TRUE)
    knit_rmd()
    file.copy("_bookdown.yml.bak", "_bookdown.yml", overwrite = TRUE)
  } else if (which == "class") {
    file.copy("_bookdown.yml", "_bookdown.yml.bak", overwrite = TRUE)
    file.copy("_bookdown_classification.yml", "_bookdown.yml", overwrite = TRUE)
    knit_rmd()
    file.copy("_bookdown.yml.bak", "_bookdown.yml", overwrite = TRUE)
  } else if (which == "comp") {
    file.copy("_bookdown.yml", "_bookdown.yml.bak", overwrite = TRUE)
    file.copy("_bookdown_comparison.yml", "_bookdown.yml", overwrite = TRUE)
    knit_rmd()
    file.copy("_bookdown.yml.bak", "_bookdown.yml", overwrite = TRUE)
  } else if (which == "meta") {
    file.copy("_bookdown.yml", "_bookdown.yml.bak", overwrite = TRUE)
    file.copy("_bookdown_meta.yml", "_bookdown.yml", overwrite = TRUE)
    knit_rmd()
    file.copy("_bookdown.yml.bak", "_bookdown.yml", overwrite = TRUE)
  } else if (which == "misc") {
    file.copy("_bookdown.yml", "_bookdown.yml.bak", overwrite = TRUE)
    file.copy("_bookdown_misc.yml", "_bookdown.yml", overwrite = TRUE)
    knit_rmd()
    file.copy("_bookdown.yml.bak", "_bookdown.yml", overwrite = TRUE)
  } else if (which == "custom") {
    file.copy("_bookdown.yml", "_bookdown.yml.bak", overwrite = TRUE)
    file.copy("_bookdown_custom.yml", "_bookdown.yml", overwrite = TRUE)
    knit_rmd()
    file.copy("_bookdown.yml.bak", "_bookdown.yml", overwrite = TRUE)
  }
}

# retrieve the arguments from the command line
rmd_built <- kniter(
  which = args$get(name = "which", required = FALSE, default = "all")
)

loginfo(selection)

