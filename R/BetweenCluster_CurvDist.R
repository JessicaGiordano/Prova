#' i-th cluster betweenness
#'
#' Hausdorff distance between i-th cluster meancurve and other clusters meancurves
#'
#' @param ClustCurve A data frame with 5 arguments : time, volume, ID, cluster membership and feature values for each curves.
#' @param i a numeric value for the cluster involved in withinness computation
#' @return a list with 4 arguments: CurveDistance is matrix for each curve hausdorff distance from each i-th cluster curves;
#' Between is a matrix for minimum and maximum hausdorff distance of i-th cluster curves from the other clusters;
#' NearCurveID and FarCurveID are the nearest and the farthest dataset curves from the i-th cluster.
#' @examples
#' @export
BetweenCluster_CurvDist <- function(ClustCurve,i)
{

 K <- length(unique(ClustCurve[,4]))
 ClustSymbol <- cluster.symbol(K)
 ### i-th cluster info
   ### curves data
   ClustCurve.i <- ClustCurve[ClustCurve[,4]==i,]
   ### curves ID
   index.i <- sort(unique(ClustCurve.i[,1]))
   ### magnitudo
   ni <- length(index.i)

 ### other clusters info
   ### curves data
   others <- ClustCurve[-which(ClustCurve[,4]==i),]
   ### curves cluster and ID
   clusterID.others <- unique(others[,c(4,1)])
   clusterID.others[,1] <- ClustSymbol[clusterID.others[,1]]
   ### curves ID
   index.others <- sort(clusterID.others[,2])
   ### other clusters magnitudo
   n.others <- length(index.others)
 ### i-th cluster distance matrix
  dist.curve <- matrix(numeric(ni*n.others),ncol=ni)
  colnames(dist.curve) <- paste("curve",index.i,"distance")
  for(j in 1:ni)
    {
     A <- ClustCurve.i[ClustCurve.i[,1]==index.i[j],2:3]
     for(k in 1: n.others)
     {
       B <- others[others[,1]==index.others[k],2:3]
       dist.curve[k,j] <- hausdorff(A,B)
     }
    }

  dist.info <- cbind(clusterID.others,dist.curve)
  other.ncluster <- K-1
  other.cluster <- unique(clusterID.others[,1])

  ### Min between dist.curveance
  betw.m <- numeric(other.ncluster)
  ### Max between dist.curveance
  betw.M <- betw.m

  ### The nearest other cluster curve to i-th cluster
  near.curve <- betw.m
  ### The farest other cluster curve to i-th cluster
  far.curve <- betw.m

  ### Betweenness
  for (p in 1: other.ncluster)
    {
    betw.m[p] <- min(dist.info[dist.info[,1]==sort(other.cluster)[p],-c(1:2)])
    betw.M[p] <- max(dist.info[dist.info[,1]==sort(other.cluster)[p],-c(1:2)])
    }

  ### Nearest and farest curve to i-th cluster
  for (p in 1: other.ncluster)
    {
      near.curve[p] <- index.others[which(dist.curve==betw.m[p],arr.ind=T)[1]]
      far.curve[p] <- index.others[which(dist.curve==betw.M[p],arr.ind=T)[1]]
    }
  between.i <- cbind(betw.m,betw.M)
  rownames(between.i) <- paste("cluster",ClustSymbol[-i])
  colnames(between.i) <- c("betw min","betw max")
  return(list(CurveDistance=dist.info,Between=between.i,NearCurveID=near.curve,FarCurveID=far.curve))
}





