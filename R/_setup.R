# Load packages -----

# library(brandr)
library(rlang)
library(downlit)
library(ggplot2)
# library(here)
library(httpgd)
# library(knitr)
# library(lubridate)
library(magrittr)
library(ragg)
# library(rutils) # github.com/danielvartan/rutils
library(showtext)
library(sysfonts)
library(vscDebugger) # github.com/ManuelHentschel/vscDebugger
library(xml2)
# library(yaml)

# Set general options -----

options(
  pillar.bold = TRUE,
  pillar.max_footer_lines = 2,
  pillar.min_chars = 15,
  scipen = 10,
  digits = 10,
  stringr.view_n = 6,
  width = 77 # 80 - 3 for #> comment
)

# Set variables -----

set.seed(2025)

# Set knitr -----

knitr::clean_cache() |> rutils::shush()

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  root.dir = here::here(),
  dev = "ragg_png",
  dev.args = list(bg = "transparent"),
  fig.showtext = TRUE
)

# Set `brandr` options -----

options(BRANDR_BRAND_YML = here::here("_brand.yml"))

brandr_options <- list(
  "BRANDR_COLOR_SEQUENTIAL" =
    brandr::get_brand_color(c("primary", "secondary")),
  "BRANDR_COLOR_DIVERGING" =
    brandr::get_brand_color(c("primary", "white", "secondary")),
  "BRANDR_COLOR_QUALITATIVE" = c(
      brandr::get_brand_color("primary"),
      brandr::get_brand_color("secondary"),
      brandr::get_brand_color("tertiary")
    )
  )

for (i in seq_along(brandr_options)) {
  options(brandr_options[i])
}

# Set and load graph fonts -----

sysfonts::font_paths(here::here("ttf"))

sysfonts::font_add(
  family = "open-sans",
  regular = here::here("ttf", "opensans-regular.ttf"),
  bold = here::here("ttf", "opensans-bold.ttf"),
  italic = here::here("ttf", "opensans-italic.ttf"),
  bolditalic = here::here("ttf", "opensans-bolditalic.ttf"),
  symbol = NULL
)

sysfonts::font_add(
  family = "source-code-pro",
  regular = here::here("ttf", "sourcecodepro-regular.ttf"),
  bold = here::here("ttf", "sourcecodepro-bold.ttf"),
  italic = here::here("ttf", "sourcecodepro-italic.ttf"),
  bolditalic = here::here("ttf", "sourcecodepro-bolditalic.ttf"),
  symbol = NULL
)

showtext::showtext_auto()

# Set `ggplot2` theme -----

ggplot2::theme_set(
  ggplot2::theme_bw() +
    ggplot2::theme(
      text = ggplot2::element_text(
        color = brandr::get_brand_color("black"),
        family = "open-sans",
        face = "plain"
      ),
      panel.background = ggplot2::element_rect(fill = "transparent"),
      plot.background = ggplot2::element_rect(
        fill = "transparent", color = NA
      ),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      legend.background = ggplot2::element_rect(fill = "transparent"),
      legend.box.background = ggplot2::element_rect(
        fill = "transparent", color = NA
      ),
      legend.frame = ggplot2::element_blank(),
      legend.ticks = ggplot2::element_line(color = "white")
    )
)
