# Obtain Athabasca Moraine Station form WISKI server
# Caroline Aubry-Wake
# Last edited Jan 20, 2021 

install.packages("devtools")
library(devtools)
install_github("CentreForHydrology/WISKIr/WISKIr")


library(WISKIr)
library (CRHMr)

Timeseries <- findWISKItimeseries('Athabasca*') # find the time series numbers, and copy into next section

ta <- getWISKIvalues('76411042','2014-09-01','2020-10-01', timezone='CST')#
qli <- getWISKIvalues('76455042','2014-09-01','2020-10-01', timezone='CST')#
qsi <- getWISKIvalues('76480042','2014-09-01','2020-10-01', timezone='CST')#
rh <- getWISKIvalues('76580042','2014-09-01','2020-10-01', timezone='CST')#
u <-  getWISKIvalues('76631042','2014-09-01','2020-10-01', timezone='CST')#
p <-  getWISKIvalues('76703042','2014-09-01','2020-10-01', timezone='CST')#

# write to obs file
ta <- WISKItoObs(ta, timezone =  'Etc/GMT+6')
qli <- WISKItoObs(lw, timezone = 'Etc/GMT+6')
qsi <- WISKItoObs(sw, timezone ='Etc/GMT+6')
rh <- WISKItoObs(rh, timezone = 'Etc/GMT+6')
u <- WISKItoObs(u, timezone = 'Etc/GMT+6')
p <- WISKItoObs(p, timezone = 'Etc/GMT+6')

# Assemble in 1 obs file
Obs <- assembleObs(ta, rh)
Obs <- assembleObs(Obs, qsi)
Obs <- assembleObs(Obs, qli)
Obs<- assembleObs(Obs, u)
Obs<- assembleObs(Obs, p)

# Plot obs
png('D:/FireandIce/fig/fig_met_processing/moraine_aws/R_ImportWiski_Athabasca_15min.png')
plotObs(Obs)
dev.off()

# Write Obs file
result <- writeObsFile(Obs, 'D:/FireandIce/data_raw/moraine_aws/WISKI/AthabascaMoraine_15min_Wiski.obs')

#################################################################
## Missing data on 20150701 to 20150713 

## load obs file
Obs<- readObsFile('D:/FireandIce/data_raw/moraine_aws/WISKI/AthabascaMoraine_15min_Wiski.obs', 'etc/GMT+6')
Obs <- changeRHtoEa(Obs)
Obs <- insertMissing(Obs)
## found the data in the centre datastore, and processed it into an obs file
gap<- readObsFile('D:/FireandIce/data_raw/moraine_aws/gap_datastore/moraineAWS_20150702_20150723_15min.obs', 'etc/GMT+6')
gap<-changeRHtoEa(gap)
gap <- gap[,c(1,2,3, 5,6,4)]

## impute the data
Obs.filled<- impute(Obs, c(1,2,3,4,5), gap, c(1,2,3,4,5))

## change ea back to RH
Obs.filled<- changeEatoRH(Obs.filled)

# Plot obs
png('D:/FireandIce/fig/fig_met_processing/moraine_aws/R_ImportWiski_Athabasca_15min_filled.png')
plotObs(Obs.filled)
dev.off()

# Write Obs file
result <- writeObsFile(Obs.filled, 'D:/FireandIce/data_raw/moraine_aws/WISKI/AthabascaMoraine_15min_Wiski_filled.obs')

#######################################################################
##  Processing raw data (Change to hourly, fill gaps)
# if only this step, load form folder
 Obs.filled<- readObsFile('D:/FireandIce/data_raw/moraine_aws/WISKI/AthabascaMoraine_15min_Wiski_filled.obs', 'etc/GMT+6')
A <- Obs.filled
A <- insertMissing(A)

## Hourly averages
A <- aggDataframe(A, c(1,2,3,4,5), 'hourly')
A<- changeRHtoEa(A);
A <- interpolate (A, c(1,2,3,4,5), 'linear', maxlength = 6)
A <- changeEatoRH(A)

# Remove bad data
bad.min <- minObs(A, minvals = c(-50, 0.5, 0, 0, 0), actions=c('NA', 'NA', 'min', 'NA', 'min'))
bad.max<- maxObs(bad.min, maxvals = c(50, 100, 1262, 800, 30), actions=c('NA', 'NA', 'NA', 'NA', 'NA'))
A <- bad.max


## plot updated obs 
png('D:/FireandIce/fig/fig_met_processing/moraine_aws/R_ImportWiski_Athabasca_hr.png')
plotObs(A)
dev.off()

result <- writeObsFile(A, 'D:/FireandIce/data_process/moraine_aws/AthabascaMoraine_1hr_Wiski.obs')


