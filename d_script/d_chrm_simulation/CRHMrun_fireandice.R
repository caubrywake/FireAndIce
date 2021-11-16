## Running CRHM for the different simulation for fire and ice
# Caroline Aubry-Wake
# Last edited Jan 25, 2021 
library(CRHMr)


############# Sim 1 - Observed ############################################################
filename = 'D:/3_FireandIce/c_CRHM/b_MainSimulation/prjfile/Sim1_MeasMETMeasAlb.prj'
outputfile = 'D:/FireandIce/CRHM/c_CRHMoutput/Sim1.txt'
result <- automatePrj(filename) 
result<-runCRHM('D:/3_FireandIce/c_CRHM/z_crhm_version/CRHM.exe', filename, outFile = outputfile)


############# Sim 2 - No soot ############################################################
filename = 'D:/3_FireandIce/c_CRHM/b_MainSimulation/prjfile/Sim2_MeasMETModAlb.prj'
outputfile = 'D:/FireandIce/CRHM/c_CRHMoutput/Sim2.txt'
result <- automatePrj(filename) 
result<-runCRHM('D:/3_FireandIce/c_CRHM/z_crhm_version/CRHM.exe', filename, outFile = outputfile)

############# Sim 3 - NO smoke ############################################################
filename = 'D:/3_FireandIce/c_CRHM/b_MainSimulation/prjfile/Sim3_ModMETMeasAlb.prj'
outputfile = 'D:/FireandIce/CRHM/c_CRHMoutput/Sim3.txt'
result <- automatePrj(filename) 
result<-runCRHM('D:/3_FireandIce/c_CRHM/z_crhm_version/CRHM.exe', filename, outFile = outputfile)

############# Sim 4 - No smoke, no soot ############################################################
filename ='D:/3_FireandIce/c_CRHM/b_MainSimulation/prjfile/Sim4_ModMETModAlb.prj'
outputfile = 'D:/FireandIce/CRHM/c_CRHMoutput/Sim4.txt'
result <- automatePrj(filename) 
result<-runCRHM('D:/3_FireandIce/c_CRHM/z_crhm_version/CRHM.exe', filename, outFile = outputfile)


