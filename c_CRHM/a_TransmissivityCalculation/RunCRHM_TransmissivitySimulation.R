# Running CRHM for transmissivty values

library(CRHMr)

##########################################################################################
#### set project name
prjname <- 'D:/3_FireandIce/c_CRHM/a_TransmissivityCalculation/TransmissivitySimulation.prj'
##  run and export results
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/3_FireandIce/c_CRHM/z_crhm_version/CRHM.exe',prjname, outFile='D:/3_FireandIce/c_CRHM/a_TransmissivityCalculation/TransmissivitySimulationOutputs.txt')
