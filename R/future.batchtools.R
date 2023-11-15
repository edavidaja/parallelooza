library(future.batchtools)
library(furrr)

plan(
  list(
    batchtools_slurm,
    multisession
    )
  )

compute <- function(n) {

  library(palmerpenguins)
  pid <- paste0("PID: ", Sys.getpid())
  host <- Sys.info()[["nodename"]]
  # Our dataset
  x <- as.data.frame(penguins[c(4, 1)])

  ind <- sample(344, 344, replace = TRUE)
  result1 <-
    glm(x[ind, 2] ~ x[ind, 1], family = binomial(logit))
  list(coefficients(result1), pid = pid, hostname = host)
}


future_map(rep(1, times = 3), ~ compute(.x))
