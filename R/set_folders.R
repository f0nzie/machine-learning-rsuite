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

project_root <- rprojroot::find_rstudio_root_file()
book_src_dir <- file.path(project_root, "work", "book")
book_out_dir <- file.path(project_root, "export", "book_out")
model_out_dir <- file.path(project_root, "export", "model_out")
data_raw_dir <- file.path(project_root, "import")
data_out_dir <- file.path(project_root, "export")
assets_dir    <- file.path(project_root, "import", "assets")

save.image(file.path(project_root, "workspace.RData"))

