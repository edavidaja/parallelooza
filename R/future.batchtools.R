library(future.batchtools)
library(furrr)

plan(
  list(
    tweak(batchtools_slurm, resources = list("memory" = 1024)),
    multisession
    )
  )

compute <- function(n) {

  library(palmerpenguins)

  # Our dataset
  x <- as.data.frame(penguins[c(4, 1)])

  ind <- sample(344, 344, replace = TRUE)
  result1 <-
    glm(x[ind, 2] ~ x[ind, 1], family = binomial(logit))
  coefficients(result1)
}


future_map(rep(1, times = 2), ~ compute(.x))
