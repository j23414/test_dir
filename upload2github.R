#! /usr/bin/env Rscript
# Auth: Jennifer Chang
# Date: 2024/12/15

# =============== Arg Processing =============== #
new_file_path <- "/Users/jchang3/Desktop/github/test/new_file.txt"

args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  stop(
    paste0(
      "Please supply the path of the file you would like to upload to github\n",
      "USAGE:    Rscript upload2github.R /full/path/to/new_file.xlsx"
      ),
    call. = FALSE)
} else if (length(args) == 1) {
  new_file_path <- args[1]
}
# ============================================== #

# Navigate to directory
working_directory <- system(paste0('dirname ', new_file_path), intern = TRUE)
setwd(working_directory)

# Loop through git pull, add, commit, and push for the new file
system('git pull')
system(paste0('git add ', new_file_path))
system(paste0('git commit -m "', Sys.Date(), ' ', new_file_path, '"'))
system('git push')
print(paste0("Uploaded file: ", new_file_path))
