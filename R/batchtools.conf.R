cluster.functions = makeClusterFunctionsSlurm(template=here::here("inst", "slurm.tmpl"))
default.resources = list(walltime = 60, ncpus=1, memory = 1024)
