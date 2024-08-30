extract_weeks_from_interval <- function(start, end) {
  checkmate::assert_date(start)
  checkmate::assert_date(end)

  lubridate::interval(start, end, tzone ="UTC") |>
    as.numeric() %>%
    `/`(as.numeric(lubridate::dweeks())) |>
    floor()
}
