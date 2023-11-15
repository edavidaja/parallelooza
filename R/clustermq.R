options(
  clustermq.scheduler = "slurm",
  clustermq.template = "clustermq.slurm.tmpl"
)

library(clustermq)

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

res <- Q(compute, n = 1:5, n_jobs = 1)
res[[1]]
