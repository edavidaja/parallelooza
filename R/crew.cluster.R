library(dplyr)
library(magrittr)

targets <- readr::read_csv(here::here("inst", "metadata.csv")) %>% 
  filter(lubridate::year(published) == 2017, !is.na(target)) %>%
  mutate(files = here::here("pdfs/", basename(target))) %>% 
  sample_n(5)

library(crew.cluster)
controller <- crew_controller_slurm(
  name = "parse_pdf",
  workers = 3L,
  seconds_idle = 300,
  slurm_memory_gigabytes_per_cpu = 1,
  script_lines = paste0("export PATH=",Sys.getenv("R_HOME"),"/bin:$PATH"),
  verbose = TRUE
)

controller$start()

results <- controller$map(
  command = iggi::parse_pdf(.x, .y),
  iterate = list(
    .x = targets$report,
    .y = targets$files
  ),
  verbose = TRUE
)

finaldata <- results$result

controller$terminate()
