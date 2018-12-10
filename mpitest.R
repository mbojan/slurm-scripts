library(Rmpi)
library(snow)
library(methods)

# create a cluster with 2 processes per node
# np <- mpi.universe.size() * 2

# create a cluster with fixed number of processes
np <- 2
cluster <- makeMPIcluster(np)

# Print the hostname for each cluster member
sayhello <- function()
{
  info <- Sys.info()[c("nodename", "machine")]
  paste("Hello from", info[1], "with CPU type", info[2])
}

message('RMPI nodes: ', mpi.comm.size())
names <- clusterCall(cluster, sayhello)
print(unlist(names))

