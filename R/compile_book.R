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
library(bookdown)

# source("R/set_folders.R")

# for testing only
book_src_dir <- file.path(project_root, "work", "book")

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


replace_in_index_rmd <- function(rmd_file, stop_word, replace, append = TRUE) {
  # stop if not Rmd file
  # stop if keyword not having colon
  space <- " "
  text <- readLines(rmd_file)
  nLine <- grep(pattern = stop_word, x = text)
  if (length(nLine) == 0) return(FALSE)
  pat <- text[nLine]
  txt_line <- grep(pattern = stop_word, x = text, value = TRUE) # get whole line
  orig_txt_line <- gsub(pattern = "title:", replacement = "", x = txt_line)
  orig_txt_line <- trimws(gsub(pattern = '\"', replacement = "",
                               x = orig_txt_line,  perl=TRUE)) # get rid of the stop_word
  if (append) {
    new_sentence <- paste0(stop_word, space, "\\'", orig_txt_line, space,
                           replace, "\\'")  # append to current sentence
  } else {
    new_sentence <- paste0(stop_word, space, "\\'",
                           replace, "\\'")  # make a new sentence
  }
  new_text <- gsub(pattern = pat, replace = new_sentence, x = text) # replace in line
  writeLines(new_text, con = rmd_file)
  # new_text[nLine]
}

set_bookdown_yaml <- function(suffix, cover_title) {
  bookdown_yaml <- "_bookdown.yml"
  file.copy(bookdown_yaml, "_bookdown.yml.bak", overwrite = TRUE)
  new_filename <- paste0(tools::file_path_sans_ext(bookdown_yaml), "_", suffix, ".yml")
  logdebug(new_filename)
  file.copy(new_filename, bookdown_yaml, overwrite = TRUE)
  replace_in_index_rmd("index.Rmd", "title:", cover_title, append = FALSE)
  knit_rmd()
  file.copy("_bookdown.yml.bak", bookdown_yaml, overwrite = TRUE)
}

# function to handle what to do with the arguments
kniter <- function(which) {
  unlink("_bookdown_files", recursive = TRUE, force = TRUE) # remove folder
  if (which == "all") {
    knit_rmd()  # do not change anything
  }  else if (which == "regre") {
    set_bookdown_yaml(suffix = "regression", cover_title = "Regression at ML")
  }  else if (which == "regre-101") {
    set_bookdown_yaml(suffix = "regression_101", cover_title = "Regression 101, ML")
  }  else if (which == "regre-202") {
    set_bookdown_yaml(suffix = "regression_202", cover_title = "Regression 202, ML")
  } else if (which == "class") {
    set_bookdown_yaml(suffix = "classification", cover_title = "Classification, ML")
  }  else if (which == "class-101") {
    set_bookdown_yaml(suffix = "classification_101", cover_title = "Classification 101, ML")
  }  else if (which == "class-202") {
    set_bookdown_yaml(suffix = "classification_202", cover_title = "Classification 202, ML")
  } else if (which == "comp") {
    set_bookdown_yaml(suffix = "comparison", cover_title = "ML Algortihms Comparison")
  } else if (which == "meta") {
    set_bookdown_yaml(suffix = "comparison", cover_title = "Meta Use of ML Algortihms")
  } else if (which == "misc") {
    set_bookdown_yaml(suffix = "misc", cover_title = "Miscellaneous ML")
  } else if (which == "custom") {
    set_bookdown_yaml(suffix = "custom", cover_title = "Customized list of ML Applications")
  }
}

# retrieve the arguments from the command line
rmd_built <- kniter(
  which = args$get(name = "which", required = FALSE, default = "all")
)

# loginfo(selection)

