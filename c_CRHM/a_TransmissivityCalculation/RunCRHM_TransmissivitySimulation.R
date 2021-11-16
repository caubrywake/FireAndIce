# Running CRHM
install.packages("usethis")
library(usethis)
install.packages("backports")
library(backports)
install.packages("devtools")
library(devtools)
install_github("CentreForHydrology/CRHMr")
library(CRHMr)


##########################################################################################
####
prjname <- 'D:/FireandIce/CRHM/TransmissivityCalculation/TransmissivitySimulation.prj'

## 
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FireandIce/CRHM/crhm_20200702/CRHM.exe',prjname, outFile='D:/FireandIce/CRHM/TransmissivityCalculation/TransmissivitySimulationOutputs.txt')
