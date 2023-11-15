options(
  clustermq.scheduler = "slurm",
  clustermq.template = "clustermq.slurm.tmpl"
)

library(clustermq)

compute <- function(n) {

  library(palmerpenguins)

  # Our dataset
  x <- as.data.frame(penguins[c(4, 1)])

  ind <- sample(344, 344, replace = TRUE)
  result1 <-
    glm(x[ind, 2] ~ x[ind, 1], family = binomial(logit))
  coefficients(result1)
}

res <- Q(compute, n = 1:1000, n_jobs = 1)
