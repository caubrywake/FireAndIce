## Process the albedo

# Caroline Aubry-Wake
# Last edited Jan 20, 2021 

install.packages("devtools")
library(devtools)
install_github("CentreForHydrology/WISKIr/WISKIr")


library(WISKIr)
library (CRHMr)

#######################################################################
# import ice AWS and moraine AWS
ice<- readObsFile('D:/FireandIce/data_raw/ice_aws/iceAWS_15min_appended_cut_albedo_2014_20200918.obs', 'etc/GMT+6')
# insert missing data steps
ice <- insertMissing(ice)
# remove max and min values
bad.min <- minObs(ice, minvals = c(0, 0, 0), actions=c('min', 'min', 'NA'))
bad.max<- maxObs(bad.min, maxvals = c(1262, 1200, 1), actions=c('max', 'NA', 'NA'))
ice.minmax <- bad.max
# interpolate over 3 hrs
ice.filled <- interpolate (ice.minmax, c(1,2, 3), 'linear', maxlength = 12)
# aggregate to hourly and inteprolate again for 3 hrs
ice.hr <-  aggDataframe(ice.filled, c(1,2,3), 'hourly')
ice.hr <-  interpolate (ice.hr, c(1,2, 3), 'linear', maxlength = 3)
# agregaate to daily
ice.daily <-  aggDataframe(ice.hr, c(1,2,3), 'daily')
ice.daily <-  interpolate (ice.daily, c(1,2, 3), 'linear', maxlength = 3)
## export obs file (daily and hourly results)
result <- writeObsFile(ice.hr, 'D:/FireandIce/data_process/ice_aws/AthabascaIce_1hr_albedo.obs')
result <- writeObsFile(ice.daily, 'D:/FireandIce/data_process/ice_aws/AthabascaIce_1day_albedo.obs')

