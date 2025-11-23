library(checkmate)
library(sodium)
library(stringr)

anonymize_id <- function(x, salt) {
  assert_atomic(x)
  assert_character(as.character(x), pattern = "^\\d{11}$")
  assert_string(salt)

  vapply(
    X = x,
    FUN = function(x, salt) {
      as.character(x) |>
        charToRaw() |>
        scrypt(salt = charToRaw(salt), size = 32) |>
        bin2hex() |>
        str_trunc(8, ellipsis = "")
    },
    FUN.VALUE = character(1),
    salt = salt,
    USE.NAMES = FALSE
  )
}
