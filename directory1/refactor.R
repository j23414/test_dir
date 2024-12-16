#! /usr/bin/env Rscript

# === Load libraries
library(readr)

# === Dummy data
subtypelineage="H1"
assay="HI"
serol_file='~/nextstrain/fludata/VIDRL-Melbourne-WHO-CC/raw-data/A/H1N1pdm/HI/2024/20240104H1N1.xlsx'
reference_long<- data.frame(x=1, y=1)
nextstrain.flatfile <- data.frame(x=1, y=1)

# === Local variables
onedrive_dir = "C:/Users/username/The Royal Melbourne Hospital/Peck, Heidi - WHO CC Melb antigenic data/oneDrive flat files/"
github_dir = "C:/Users/username/github/VIDRL-Melbourne-WHO-CC/flat-files"

# === Infer the subdirectory
subdir <- paste0(subtypelineage, "/", assay, "/")
if(subdir %in% c("H1/HI/", "BVic/HI/")){
  subdir <- paste0(subtypelineage, "/")
}

# === Write to OneDrive directory
write_csv(
  reference_long,
  file = paste0(onedrive_dir, subdir, basename(serol_file), "_", subtypelineage, "_reference_panel.csv")
)

write_csv(
  nextstrain.flatfile,
  file = paste0(onedrive_dir, subdir, basename(serol_file), "_", subtypelineage,"_flat_file.csv")
)

# === Write to GitHub directory
reference_panel_file = paste0(github_dir, subdir, basename(serol_file), "_", subtypelineage, "_reference_panel.csv")
flat_file = paste0(github_dir, subdir, basename(serol_file), "_", subtypelineage,"_flat_file.csv")

write_csv(reference_long, file = reference_panel_file)
write_csv(nextstrain.flatfile, file = flat_file)

# === Update GitHub (may be swapped out for other method)
# Loop through git pull, add, commit, and push for the new file
setwd(github_dir)
system('git pull')
system(paste0('git add ', reference_panel_file, " ", flat_file))
system(paste0('git commit -m "', Sys.Date(), ' ', basename(serol_file), '"'))
system('git push')
print(paste0("Uploaded file: ", new_file_path))


