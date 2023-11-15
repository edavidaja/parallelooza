library(crew.cluster)

controller <- crew_controller_slurm(
  host = Sys.info()["nodename"],
  name = "crew",
  workers = 2,
  slurm_cpus_per_task = 1,
  slurm_memory_gigabytes_per_cpu = 1024
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

controller$start()
controller$push(name = "fit model", command = compute())
controller$pop()
controller$terminate()
