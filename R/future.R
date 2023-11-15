library(purrr)
library(furrr)

plan(multisession)

compute <- function(n) {

  library(palmerpenguins)
  message(paste0("PID: ", Sys.getpid()))

  # Our dataset
  x <- as.data.frame(penguins[c(4, 1)])

  ind <- sample(344, 344, replace = TRUE)
  result1 <-
    glm(x[ind, 2] ~ x[ind, 1], family = binomial(logit))
  coefficients(result1)
}

map(rep(1, times = 3), ~ compute(.x))
future_map(rep(1, times = 3), ~ compute(.x))
