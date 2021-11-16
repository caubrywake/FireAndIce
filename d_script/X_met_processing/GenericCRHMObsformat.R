## Generic processing obs file for CRHM
# Caroline Aubry-Wake
# Last edited Jan 20, 2021 

install.packages("devtools")
library(devtools)
install_github("CentreForHydrology/WISKIr/WISKIr")

library (CRHMr)

ice<- readObsFile('D:/FireandIce/data_process/ice_aws/AthabascaIce_1hr.obs', 'etc/GMT+6')
result <- writeObsFile(ice,'D:/FireandIce/data_process/ice_aws/AthabascaIce_1hr.obs')

ice<- readObsFile('D:/FireandIce/data_process/moraine_aws/moraineAWS_precip_hourly.obs', 'etc/GMT+6')
result <- writeObsFile(ice,'D:/FireandIce/data_process/moraine_aws/moraineAWS_precip_hourly.obs')

ice<- readObsFile('D:/FireandIce/data_process/ice_aws/iceAWS_alb_daily.obs', 'etc/GMT+6')
result <- writeObsFile(ice,'D:/FireandIce/data_process/ice_aws/iceAWS_alb_daily.obs')
# for the simulations
ice1<- readObsFile('D:/FireandIce/data_process/ice_aws/iceAWS_TRHUQsiQliPalb.obs', 'etc/GMT+6')
result <- writeObsFile(ice1,'D:/FireandIce/data_process/ice_aws/iceAWS_TRHUQsiQliPalb.obs')

ice2<- readObsFile('D:/FireandIce/data_process/ice_aws/iceAWS_TRHUQsiQliPalb_modAlb.obs', 'etc/GMT+6')
result <- writeObsFile(ice2,'D:/FireandIce/data_process/ice_aws/iceAWS_TRHUQsiQliPalb_modAlb.obs')

ice3<- readObsFile('D:/FireandIce/data_process/ice_aws/iceAWS_TRHUQsiQliPalb_modRad.obs', 'etc/GMT+6')
result <- writeObsFile(ice3,'D:/FireandIce/data_process/ice_aws/iceAWS_TRHUQsiQliPalb_modRad.obs')

ice4<- readObsFile('D:/FireandIce/data_process/ice_aws/iceAWS_TRHUQsiQliPalb_modRad_modAlb.obs', 'etc/GMT+6')
result <- writeObsFile(ice4,'D:/FireandIce/data_process/ice_aws/iceAWS_TRHUQsiQliPalb_modRad_modAlb.obs')
