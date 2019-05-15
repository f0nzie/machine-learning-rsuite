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



# remove files and subfolders under book
remove_files_subdirs <- function(the_folder) {
  # deletes files and folders
  file.remove(list.files(the_folder, full.names = TRUE, recursive = TRUE)) # remove files
  subdirs_book <- list.dirs(the_folder, full.names = TRUE, recursive = TRUE)[-1] # ignore book
  unlink(subdirs_book, recursive = TRUE, force = TRUE) # remove subfolders
}

load(file.path(rprojroot::find_rstudio_root_file(), "workspace.RData"))

NOT_RMD        <- list.files(book_src_dir, pattern = "*.html|*.Rmd~|*.pdf|*.log",
                             full.names = TRUE)

file.remove(NOT_RMD)

remove_files_subdirs(book_out_dir)
remove_files_subdirs(book_src_dir)
# remove_files_subdirs(REPORT_OUTPUT)

