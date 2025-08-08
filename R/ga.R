# library(checkmatem, quietly = TRUE)
# library(cli, quietly = TRUE)
# library(lubridate, quietly = TRUE)
# library(rutils, quietly = TRUE)

#' Computes the gestational age start date
#'
#' This function computes the gestational age __start__ date given the
#' ultrasound date and the __actual__ gestational age.
#'
#' @param ultrasound A [`Date`][base::as.Date()] object representing the
#'  ultrasound date.
#' @param ga A [`Period`][lubridate::period] object representing the
#'   gestational age.
#'
#' @return A [`Date`][base::as.Date()] object representing the gestational age
#'  start date.
#' @export
#'
#' @examples
#' ga_start(
#'   ultrasound = lubridate::dmy("18/10/2022"),
#'   ga = lubridate::weeks(6) + lubridate::days(3)
#' )
#' #> [1] "2022-09-03"
#'
#' ga_start(
#'   ultrasound = lubridate::dmy("18/10/2022"),
#'   ga = lubridate::period(1, "month") + lubridate::days(10)
#' )
#' #> [1] "2022-09-08"
ga_start <- function(ultrasound, ga) {
  checkmate::assert_date(ultrasound)
  prettycheck:::assert_period(ga, lower = lubridate::period(0))
  prettycheck:::assert_identical(ultrasound, ga, type = "length")

  lubridate::as_date(ultrasound - ga)
}

ga_point <- function(ga_start, point, print = FALSE) {
  checkmate::assert_date(ga_start)
  checkmate::assert_multi_class(point, c("Date", "POSIXt"))
  checkmate::assert_flag(print)

  for (i in seq_along(ga_start)) {
    for (j in seq_along(point)) {
      if (point[i] < ga_start[i]) {
        cli::cli_abort(paste(
          "{.strong {cli::col_red('point')}} must be equal or greater than",
          "{.strong {cli::col_blue('ga_start')}}."
        ))
      }
    }
  }

  ga_start <- ga_start |> lubridate::as_date()
  point <- point |> lubridate::as_date()

  out <-
    lubridate::interval(ga_start, point, tzone ="UTC") |>
    as.numeric() %>%
    `/`(as.numeric(lubridate::ddays())) %>%
    lubridate::days()

  if (isTRUE(print)) {
    out_duration <- out |> lubridate::as.duration()

    weeks <- floor(out_duration / lubridate::dweeks())
    days <- out_duration %% lubridate::dweeks() / lubridate::ddays()

    cli::cli_alert_info(paste(
      "{.strong",
      "{weeks} {.strong {cli::col_red('week(s)')}}",
      "{days} {.strong {cli::col_red('day(s)')}}",
      "}"
    ))
  }

  invisible(out)
}

ga_week_int <- function(ga_start, week) {
  checkmate::assert_date(ga_start, len = 1)
  checkmate::assert_number(week, lower = 0)

  week_start <-
    (ga_start + lubridate::dweeks(week)) |>
    lubridate::as_date()

  week_end <-
    (week_start + lubridate::dweeks(1) - lubridate::dseconds(1)) |>
    lubridate::as_date()

  lubridate::interval(week_start, week_end)
}

ga_weeks <- function(ga) {
  prettycheck:::assert_period(ga)

  ga <- ga |> lubridate::as.duration()

  floor(ga / lubridate::dweeks())
}

ga_days <- function(ga) {
  prettycheck:::assert_period(ga)

  ga <- ga |> lubridate::as.duration()
  weeks <- floor(ga / lubridate::dweeks())

  ga %% lubridate::dweeks() / lubridate::ddays()
}

ga_weeks_days <- function(ga) {
  prettycheck:::assert_period(ga)

  ga <- ga |> lubridate::as.duration()
  weeks <- floor(ga / lubridate::dweeks())
  days <- ga %% lubridate::dweeks() / lubridate::ddays()

  paste0(weeks, "/", days)
}
