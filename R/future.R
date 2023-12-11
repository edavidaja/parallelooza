library(dplyr)
library(magrittr)

targets <- readr::read_csv(here::here("inst", "metadata.csv")) %>% 
  filter(lubridate::year(published) == 2017, !is.na(target)) %>%
  mutate(files = here::here("pdfs/", basename(target))) %>% 
  sample_n(5)

library(purrr)


targets %$%
  map2(report, files, ~ parse_pdf(.x, .y))

# just add cores ----------------------------------------------------------

library(furrr)
plan(multisession)

targets %$%
  future_map2(report, files, ~ iggi::parse_pdf(.x, .y))
