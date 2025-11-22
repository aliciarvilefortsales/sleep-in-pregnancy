library(checkmate)
library(cli)
library(lubridate)
library(prettycheck)
library(rutils)

#' Computes the gestational age start date
#'
#' `ga_start()` computes the gestational age **start** date given the
#' ultrasound date and the **actual** gestational age.
#'
#' @param ultrasound A [`Date`][base::as.Date()] object representing the
#'  ultrasound date.
#' @param ga A [`Period`][period] object representing the gestational age.
#'
#' @return A [`Date`][base::as.Date()] object representing the gestational age
#'  start date.
#'
#' @export
#' @noRd
#'
#' @examples
#' ga_start(
#'   ultrasound = dmy("18/10/2022"),
#'   ga = weeks(6) + days(3)
#' )
#' #> [1] "2022-09-03" # Expected
#'
#' ga_start(
#'   ultrasound = dmy("18/10/2022"),
#'   ga = period(1, "month") + days(10)
#' )
#' #> [1] "2022-09-08" # Expected
ga_start <- function(ultrasound, ga) {
  assert_date(ultrasound)
  assert_period(ga, lower = period(0))
  assert_identical(ultrasound, ga, type = "length")

  as_date(ultrasound - ga)
}

ga_point <- function(ga_start, point, print = FALSE) {
  assert_date(ga_start)
  assert_multi_class(point, c("Date", "POSIXt"))
  assert_flag(print)

  for (i in seq_along(ga_start)) {
    for (j in seq_along(point)) {
      if (point[i] < ga_start[i]) {
        cli_abort(paste(
          "{.strong {col_red('point')}} must be equal or greater than",
          "{.strong {col_blue('ga_start')}}."
        ))
      }
    }
  }

  ga_start <- ga_start
  point <- point |> as_date()

  out <-
    lubridate::interval(ga_start, point, tzone ="UTC") |>
    as.numeric() %>%
    `/`(as.numeric(ddays())) %>%
    days()

  if (isTRUE(print)) {
    out_duration <- out |> as.duration()

    weeks <- floor(out_duration / dweeks())
    days <- out_duration %% dweeks() / ddays()

    cli_alert_info(paste(
      "{.strong",
      "{weeks} {.strong {col_red('week(s)')}}",
      "{days} {.strong {col_red('day(s)')}}",
      "}"
    ))
  }

  out
}

ga_week_int <- function(ga_start, week) {
  assert_date(ga_start, len = 1)
  assert_number(week, lower = 0)

  week_start <-
    (ga_start + dweeks(week)) |>
    as_date()

  week_end <-
    (week_start + dweeks(1) - dseconds(1)) |>
    as_date()

  interval(week_start, week_end)
}

ga_weeks <- function(ga) {
  assert_period(ga)

  ga <- ga |> as.duration()

  floor(ga / dweeks())
}

ga_days <- function(ga) {
  assert_period(ga)

  ga <- ga |> as.duration()
  weeks <- floor(ga / dweeks())

  ga %% dweeks() / ddays()
}

ga_weeks_days <- function(ga) {
  assert_period(ga)

  ga <- ga |> as.duration()
  weeks <- floor(ga / dweeks())
  days <- ga %% dweeks() / ddays()

  paste0(weeks, "/", days)
}
