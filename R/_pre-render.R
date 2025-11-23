## Load Packages -----

library(checkmate)
library(fs)
library(here)
library(quartor) # github.com/danielvartan/quartor
library(rbbt)

# Copy Images Folder to `qmd` Directory -----

## *Solve issues related to relative paths

qmd_dir <- here("qmd", "images")

if (!test_directory_exists(qmd_dir)) {
  dir.create(qmd_dir) |> invisible()
}

for (i in dir_ls(here("images"), type = "file")) {
  file_copy(
    path = i,
    new_path = path(qmd_dir, basename(i)),
    overwrite = TRUE
  )
}

# Run `rbbt` -----

## Uncheck the option "Apply title-casing to titles" in Zotero Better BibTeX
## preferences (Edit > Settings > Better BibTeX > Miscellaneous).

# (2024-08-25)
# This function should work with any version of BetterBibTeX (BBT) for Zotero.
# Verify if @wmoldham PR was merged in the `rbbt` package (see issue #47
# <https://github.com/paleolimbot/rbbt/issues/47>). If not, install `rbbt`
# from @wmoldham fork `remotes::install_github("wmoldham/rbbt", force = TRUE)`.

# bbt_write_quarto_bib(
#   bib_file = here("references.bib"),
#   dir = c("."),
#   pattern = "\\.qmd$",
#   wd = here()
# )
