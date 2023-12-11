library(dplyr)
library(magrittr)

targets <- readr::read_csv(here::here("inst", "metadata.csv")) %>% 
  filter(lubridate::year(published) == 2017, !is.na(target)) %>%
  mutate(files = here::here("pdfs/", basename(target))) %>% 
  sample_n(5)


options(
  clustermq.scheduler = "slurm",
  clustermq.template = here::here("inst", "clustermq.slurm.tmpl")
)

library(clustermq)
library(iggi)

res <- Q(
  iggi::parse_pdf, 
  report_id = targets$report, file = targets$files, 
  n_jobs = 2,
  pkgs = c("magrittr", "pdftools", "tesseract", "purrr", "dplyr", "stringr", "iggi")
  )
