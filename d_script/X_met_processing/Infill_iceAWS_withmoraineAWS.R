## Infill athbasca ice with athabasca moraine data
# Caroline Aubry-Wake
# Last edited Jan 20, 2021 

install.packages("devtools")
library(devtools)
install_github("CentreForHydrology/WISKIr/WISKIr")


library(WISKIr)
library (CRHMr)

#######################################################################
# import ice AWS and moraine AWS
ice<- readObsFile('D:/FireandIce/data_process/ice_aws/AthabascaIce_1hr.obs', 'etc/GMT+6')
ice<-insertMissing(ice)
mor<- readObsFile('D:/FireandIce/data_process/moraine_aws/AthabascaMoraine_1hr_Wiski.obs', 'etc/GMT+6')

# change RH to Ea
ice <- changeRHtoEa(ice)
mor <- changeRHtoEa(mor)

# reorder column
mor <- mor[,c(1,2,3,6, 4,5)]

# calculate regression coefficient
reg <- regress(ice, c(1,2,3,4,5), mor, c(1,2,3,4,5))
reg$intercept[3]<-0
reg$intercept[4]<-0

# impute moraine AWSinto ice AWS gap
ice.filled <- impute(ice, c(1,2,3,4,5), mor, c(1,2,3,4,5), multipliers = reg$slope, offsets=reg$intercept)

## Interpolate betwene missing data (if there still are some)
ice.filled <- interpolate (ice.filled, c(1,2,3,4,5), 'linear', maxlength = 6)

## Delete spikes in temperature
ice.filled<- deleteSpikes(ice.filled, 1, 5)

## Interpolate over spikes
ice.filled <- interpolate (ice.filled, c(1,2,3,4,5), 'linear', maxlength = 6)

# change back to RH
ice.filled <- changeEatoRH(ice.filled)


## plot infilled ice AWS
png('D:/FireandIce/fig/fig_met_processing/ice_aws/R_filled_iceAWS.png')
plotObs(ice.filled)
dev.off()

## save obs file
result <- writeObsFile(ice.filled, 'D:/FireandIce/data_process/ice_aws/AthabascaIce_1hr.obs')


