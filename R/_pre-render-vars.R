# Load packages -----

# library(dplyr)
# library(lubritime)
library(magrittr)
library(targets)

# Load functions -----

source(here::here("R", "utils.R"))

# Load variables -----

env_vars <- yaml::read_yaml(here::here("_variables.yml"))
res_vars <- yaml::read_yaml(here::here("_results.yml"))

# Load data -----

# targets::tar_make(script = here::here("_targets.R"))

raw_data <- targets::tar_read(
  "raw_data",
  store = here::here("_targets")
)

tidy_data <- targets::tar_read(
  "tidy_data",
  store = here::here("_targets")
)

# Chapter 1 -----

# Others -----

# Write in `results.yml` -----

write_in_results_yml(
  list()
)

# Clean environment -----

rm(
  raw_data,
  tidy_data
)

# Reload `result_vars` -----

res_vars <- yaml::read_yaml(here::here("_results.yml"))
