# Qa/Qc data from on-ice AWS at Athabasca
# Caroline Aubry-Wake
# Last edited Jan 20, 2021 

install.packages("devtools")
library(devtools)
install_github("CentreForHydrology/WISKIr/WISKIr")


library(WISKIr)
library (CRHMr)

#######################################################################
##  Processing raw data (Change to hourly, fill gaps)
######################################################################

Obs<- readObsFile('D:/FireandIce/data_process/ice_aws/iceAWS_15min.obs', 'etc/GMT+6')
Obs <- insertMissing(Obs)

## Remove bad data
bad.min <- minObs(Obs, minvals = c(-25, 0.5, 0, 0, 0, 0), actions=c('NA', 'NA', 'min', 'min', 'min', 'NA'))
bad.max<- maxObs(bad.min, maxvals = c(25, 100, 30, 1262, 800, 0.25), actions=c('NA', 'NA', 'NA', 'NA', 'NA', 'max'))

A <- bad.max
## Hourly sum (or average)
A <- aggDataframe(A, c(1,2,3,4,5), 'hourly')
A <- changeRHtoEa(A)
A <- interpolate (A, c(1,2,3,4,5), 'linear', maxlength = 6)
A <- changeEatoRH(A)

## plot updated obs 
png('D:/FireandIce/fig/fig_met_processing/ice_aws/R_QC_OnIce_Athabasca_1hr.png')
plotObs(A)
dev.off()

result <- writeObsFile(A, 'D:/FireandIce/data_process/ice_aws/AthabascaIce_1hr.obs')

