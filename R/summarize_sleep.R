library(checkmate)
library(dplyr)
library(here)

source(here("R", "summarize_hfs.R"))

summarize_sleep_by_id <- function(data, id_filter = NULL) {
  assert_tibble(data)
  assert_flag(id_filter, null.ok = TRUE)

  if (!is.null(id_filter)) {
    data <- data |> filter(id %in% id_filter)
  }

  data |>
  mutate(
    group = case_when(
      id %in% regular_sri_ids ~ "regular",
      id %in% others_sri_ids ~ "others",
      id %in% irregular_sri_ids ~ "irregular"
    )
  ) |>
  summarize(
    n = n(),
    his_mean = summarize_his(his, mean, na.rm = TRUE),
    his_sd = summarize_his(his, sd, na.rm = TRUE),
    his_min = summarize_his(his, min, na.rm = TRUE),
    his_max = summarize_his(his, max, na.rm = TRUE),
    hfs_mean = summarize_hfs(hfs, mean, na.rm = TRUE),
    hfs_sd = summarize_hfs(hfs, sd, na.rm = TRUE),
    hfs_min = summarize_hfs(hfs, min, na.rm = TRUE),
    hfs_max = summarize_hfs(hfs, max, na.rm = TRUE),
    across(
      .cols = c(fps, tts, waso),
      .fns = list(
        mean = \(x) x |> mean(na.rm = TRUE) |> as_hms(),
        sd = \(x) x |> sd(na.rm = TRUE) |> as_hms(),
        min = \(x) x |> min(na.rm = TRUE) |> as_hms(),
        max = \(x) x |> max(na.rm = TRUE) |> as_hms()
      ),
      .names = "{.col}_{.fn}"
    ),
    across(
      .cols = c(tts_fps, awakenings),
      .fns = list(
        mean = \(x) x |> mean(na.rm = TRUE),
        sd = \(x) x |> sd(na.rm = TRUE),
        min = \(x) x |> min(na.rm = TRUE),
        max = \(x) x |> max(na.rm = TRUE)
      ),
      .names = "{.col}_{.fn}"
    ),
    .by = group
  ) |>
  arrange(desc(group))
}
