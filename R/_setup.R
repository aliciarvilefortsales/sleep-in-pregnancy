# Load Packages -----

library(brandr)
library(downlit)
library(ggplot2)
library(here)
library(knitr)
library(magrittr)
library(quartor) # github.com/danielvartan/quartor
library(ragg)
library(showtext)
library(sysfonts)
library(xml2)

# Set General Options -----

options(
  dplyr.print_min = 6,
  dplyr.print_max = 6,
  pillar.max_footer_lines = 2,
  pillar.min_chars = 15,
  scipen = 10,
  digits = 10,
  stringr.view_n = 6,
  pillar.bold = TRUE,
  width = 77 # 80 - 3 for #> comment
)

# Set Variables -----

set.seed(2025)

# Set `knitr`` -----

clean_cache() |> suppressWarnings()

opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  root.dir = here(),
  dev = "ragg_png",
  dev.args = list(bg = "transparent"),
  fig.showtext = TRUE
)

# Set `brandr` Options -----

options(BRANDR_BRAND_YML = here("_brand.yml"))

brandr_options <- list(
  "BRANDR_COLOR_SEQUENTIAL" =
    get_brand_color(c("primary", "secondary")),
  "BRANDR_COLOR_DIVERGING" =
    get_brand_color(c("primary", "white", "secondary")),
  "BRANDR_COLOR_QUALITATIVE" = c(
      get_brand_color("primary"),
      get_brand_color("secondary"),
      get_brand_color("tertiary")
    )
  )

for (i in seq_along(brandr_options)) {
  options(brandr_options[i])
}

# Set and Load Graph Fonts -----

font_paths(here("ttf"))

font_add(
  family = "arimo",
  regular = here("ttf", "arimo-regular.ttf"),
  bold = here("ttf", "arimo-bold.ttf"),
  italic = here("ttf", "arimo-italic.ttf"),
  bolditalic = here("ttf", "arimo-bolditalic.ttf"),
  symbol = NULL
)

font_add(
  family = "source-code-pro",
  regular = here("ttf", "sourcecodepro-regular.ttf"),
  bold = here("ttf", "sourcecodepro-bold.ttf"),
  italic = here("ttf", "sourcecodepro-italic.ttf"),
  bolditalic = here("ttf", "sourcecodepro-bolditalic.ttf"),
  symbol = NULL
)

showtext_auto()

# Set `ggplot2` Theme -----

theme_set(
  theme_bw() +
    theme(
      text = element_text(
        color = "black",
        family = "arimo",
        face = "plain"
      ),
      panel.background = element_rect(fill = "transparent"),
      plot.background = element_rect(
        fill = "transparent", color = NA
      ),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.background = element_rect(fill = "transparent"),
      legend.box.background = element_rect(
        fill = "transparent", color = NA
      ),
      legend.frame = element_blank(),
      legend.ticks = element_line(color = "white")
    )
)
