# FireAndIce
Code for the Fire and Ice project
The includes the main input files, processing script and CRHM simulations files for the Fire and Ice project. The folders and files are generally organized in processing order. 

b_data_process: clean MET, albedo and melt files
  - meteorological data for the on-ice weather station on the Athabasca glacier
  - the corrected precipitation at the moraine AWS
  - albedo from the on-ice station
  - surface lowering calculate from the SR50 at the on-ice station

c_CRHM: observation and project files for the CRHM simulations
  - a_TransmissivityCalculation: model files for the CRHM simulation  to calculate transmissivities, used to modify measured radiation to acocunt for smoke removal
  - b_MainSimulation: the four scenarios to simulate surface melt without the soot and smoke impact
  - c_CRHMoutput: the output files for the main simulations

d_script: matlab and R scripts
  - a_timelapse_classification: classify images between the different weather types (clear, cloudy, smoky)
  - b_met_analysis: extract and averages meterological variables (T, RH, U, Sw, LW) based on weather types (clear, cloudy, smoky)
  - c_radiation_modification: using the transmissity values from the CRHM simulation, caluclate the change in transmissivity due to the smoke and applies it to measured SW and LW, and create obs file for the CRHM simulation
  - d_chrm_simulation: import and analyze the CRHM main simulation outputs

e_function: function used in the analysis

f_fig: key figures from the analysis

h_output: key output tables and files from the analysis
