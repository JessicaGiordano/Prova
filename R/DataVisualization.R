#' Data Visualitation
#'
#' DataVisualization() returns a plot that compares the density time grid and  the growth curves plot
#' in order to understand if it is useful truncate the data and so choose the truncation time.
#'
#'
#' @param alldata List containing the number of observations per each curve (called LenCurv),
#'                and a data frame constituted from the curves' ID, observed values and the respective times.
#'                It is generated automatically from the function DataImport().
#' @param feature String feature name, stored in the target file, to plot curves according to.
#' @param labels  The text for the axis and plot title.
#' @param save When TRUE (the default is FALSE), it is possible to save a plot that compares the density time grid and
#'             the growth curves plot in a pdf.
#' @param path Path to save plot to (combined with filename).
#' @return alldata list DataImport() output with feature color palette.
#' @import ggplot2 cowplot
#' @export
DataVisualization <- function(alldata,feature,labels=NULL,save=FALSE,path=NULL)
{

 ### Variables initialization
 growth.curves <- GrowthCurve(alldata,feature,labels=labels)
 plot1 <- growth.curves$GrowthCurve_plot
 plot2 <- TimeGridDensity(alldata)

 plots <- plot_grid(plotlist=list(plot1 , plot2))

 if(save==TRUE)
 {
     ggsave(filename="DataVisualization.pdf",plot =plots,width=29, height = 20, units = "cm",scale = 1,path=path )
 }
 return(plots)
}

