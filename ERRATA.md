# Errata

## 2023-11-15

While presenting at the [Research Computing Series for Syracuse University](https://researchcomputing.syr.edu/events/), I illustrated using `clustermq` for parallelizing jobs but did not correctly demonstrate getting the jobs to run across multiple nodes.
The [`jobs` argument](https://github.com/edavidaja/parallelooza/blob/7f754dd060e04c6770187cd2600a845faf58e61d/R/clustermq.R#L22) to `Q()` must be set to more than 1.
