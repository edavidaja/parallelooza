source("renv/activate.R")

#set SLURM binaries PATH so that RSW Launcher jobs work
slurm_bin_path<-"/opt/slurm/bin"

curr_path<-strsplit(Sys.getenv("PATH"),":")[[1]]

if (!(slurm_bin_path %in% curr_path)) {
  if (length(curr_path) == 0) {
    Sys.setenv(PATH = slurm_bin_path)
  } else {
    Sys.setenv(PATH = paste0(Sys.getenv("PATH"),":",slurm_bin_path))
  }

}
