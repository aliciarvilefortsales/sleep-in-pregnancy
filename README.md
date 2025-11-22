# sleep-in-pregnancy

<!-- quarto render -->

<!-- badges: start -->
[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![](https://img.shields.io/badge/OSF%20DOI-10.17605/OSF.IO/EAPZU-1284C5.svg)](https://doi.org/10.17605/OSF.IO/S4TBZ)
[![License:
GPLv3](https://img.shields.io/badge/license-GPLv3-bd0000.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![License: CC BY-NC-SA
4.0](https://img.shields.io/badge/license-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
<!-- badges: end -->

## Overview

This repository contains materials for the study: *Associations Between
the Duration and Quality of Sleep in Third-Trimester Pregnant Women with
the Duration of Labor*. The full research compendium, including data and
supplementary materials, is available on the Open Science Framework
([OSF](https://osf.io/)) at: <https://doi.org/10.17605/OSF.IO/S4TBZ>

## Keys

To access the data and run the [Quarto](https://quarto.org/) notebooks
in the `qmd` folder, you must first obtain authorization to access the
project’s [OSF](https://osf.io) repositories and [Google
Sheets](https://workspace.google.com/products/sheets/) files.

Once you have the necessary permissions, run the following command to
authorize your access to the Google Sheets API:

``` r
library(gargle)
library(googlesheets4)

options(gargle_oauth_cache = ".secrets")

gs4_auth()
gargle_oauth_cache()
```

Next, create a file named
[`.Renviron`](https://bookdown.org/csgillespie/efficientR/set-up.html#:~:text=2.4.6%20The%20.Renviron%20file)
in the root directory of the project and add the following environment
variables:

- `OSF_PAT`: Your [OSF](https://osf.io/) Personal Access Token
  ([PAT](https://en.wikipedia.org/wiki/Personal_access_token)). If you
  don’t have one, go to the settings section of your OSF account and
  create a new token.
- `PREGNANCY_PASSWORD`: The password for the project’s
  [RSA](https://en.wikipedia.org/wiki/RSA_cryptosystem) private key (32
  bytes).
- `PREGNANCY_SALT`: The salt used for anonymizing participant IDs (32
  bytes).

Example (do not use these values):

``` ini
OSF_PAT=bWHtQBmdeMvZXDv2R4twdNLjmakjLUZr4t72ouAbNjwycGtDzfm3gjz4ChYXwbBaBVJxJR
PREGNANCY_PASSWORD=MmXN_od_pe*RdHgfKTaKiXdV7KD2qPzW
PREGNANCY_SALT=iLG*Vu7@2c-KxY_LeQW4D6Kc2aFivvy2
```

Additionally, you will need the following keys in the project’s
[`_ssh`](_ssh) folder:

- `id_rsa`: The project’s private RSA key
  ([RSA](https://en.wikipedia.org/wiki/RSA_cryptosystem) 4096 bits
  (OpenSSL)).
- `id_rsa.pub`: The project’s public RSA key.

These project’s keys are provided to authorized personnel only. If you
need access, please contact the author.

## License

[![License:
GPLv3](https://img.shields.io/badge/license-GPLv3-bd0000.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![License: CC BY-NC-SA
4.0](https://img.shields.io/badge/license-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

The code in this repository is licensed under the [GNU General Public
License Version 3](https://www.gnu.org/licenses/gpl-3.0), while the
documents are available under the [Creative Commons
Attribution-NonCommercial-ShareAlike 4.0
International](https://creativecommons.org/licenses/by-nc-sa/4.0/).

The research data is subject to a private license and is not publicly
available due to privacy and ethical considerations.

``` text
Copyright (C) 2025 Alícia Rafaelly Vilefort Sales

The code in this repository is free software: you can redistribute it and/or
modify it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <https://www.gnu.org/licenses/>.
```

## Acknowledgments

<table>
  <tr>
    <td width="30%">
      <br/>
      <p align="center">
        <a href="https://www.gov.br/capes/">
          <img src="images/capes-logo.svg" width="125"/>
        </a>
      </p>
      <br/>
    </td>
    <td width="70%">
      <p>
        This study was financed by the Coordenação de Aperfeiçoamento de
        Pessoal de Nível Superior - Brazil (<a href="https://www.gov.br/capes/">CAPES</a>) - Finance Code 001, Grant Number 88887.940089/2024-00.
      </p>
    </td>
  </tr>
</table>
