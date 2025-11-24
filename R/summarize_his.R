library(checkmate)
library(hms)
library(prettycheck) # github.com/danielvartan/prettycheck

summarize_his <- function(
  x,
  fun = mean,
  threshold = parse_hm("12:00"),
  ...
) {
  assert_hms(x)
  assert_function(fun)
  assert_length(threshold, len = 1)

  assert_hms(
    threshold,
    lower = hms::hms(0),
    upper = hms::parse_hms("23:59:59")
  )

  x |>
    link_to_timeline(threshold = threshold) |>
    as.numeric() |>
    fun(...) |>
    as_hms()
}

summarize_hfs <- function(x, fun, threshold = parse_hm("18:00"), ...) {
  summarize_his(x, fun, threshold = threshold, ...)
}
