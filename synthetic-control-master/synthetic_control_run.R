#This is the file used to set variables to be used in analysis, as well as to run the analysis.
#Make sure *_analysis.R, *_report.R, *_report.Rmd, *_functions.R, and *_plot.R are all in the same folder as this file.
#Model the setup shown in this file, then run this file from the console using source('This file's directory/This file's name'). 

#Clear the workspace
rm(list = ls(all = TRUE))
gc()

#Set the working directory
#This step only works as written if this file is run using the source() command. Otherwise, skip this step and set manually.

###WORKING DIRECTORY Should be set as the directory where .Rmd file is saved  ####
#setwd('~/synthetic-control-master/main analysis components')  #directory where .Rmd file is saved
#Set working directory: default to desktop--different path for windows vs Mac
#if(.Platform$OS.type == "windows") {
#  desktop<-file.path(Sys.getenv("USERPROFILE"),"Desktop")
#  desktop<-gsub(pattern='\\',replacement='/', desktop, fixed=TRUE)
#} else {
#  desktop<- "~/Desktop"
#}
#setwd(file.path(paste0(desktop,'/synthetic-control-master/main analysis components/')))

#setwd("~/Not Backing Up to Google/PCV Impact Mortality/Analysis/Synthetic Controls analysis/Corrected code received 31Jan19/synthetic-control-master/main analysis components")

#Used to check for relevant packages and update them if out of date or install them if not installed.
update_packages  <- TRUE #Whether to update outdated packages.
install_packages <- TRUE #Whether to install missing packages.
install_pandoc   <- TRUE #Whether to install pandoc, which requires an external installer, and rmarkdown, a package that depends on pandoc's successful installation.

#Assign variable values
country       <- 'South Africa' #Country or region name.
n_seasons     <- 12       #Number of months (seasons) per year. 12 for monthly, 4 for quarterly, 3 for trimester data.
exclude_covar <- c('AllRes', 	'PI', 	'POth', 	'AllDiar', 	'Pneum', 	'Menin', 	'BactMenin', 	'Bact', 	'OtMed', 	'Mast',	'SeptArthr', "denom", "A20_B99_excl_bac", "A16", "A17", "A18", "A19", "R00_R09", "R10_R19", "R20_R39", "R40_R49", "R50_R69", "R70_R94", "R95_R99", "D50_D89")      
exclude_group <- c()      #User-defined list of groups to exclude from analyses.
code_change   <- FALSE


input_directory  <- '' #Directory (or URL) containing input data file. JK: Leave this blank and just copy data directly into the file with the R files
output_directory <- '..\\Results/Results'   #Directory where results will be saved.
output_directory <- paste(output_directory, format(Sys.time(), '%Y-%m-%d-%H%M%S'), '/', sep = '')                     #Adds a subfolder to output directory to organize results by date and time run.
file_name        <- 'RSA.csv'  #Name of file containing data for analysis. Must be a .csv file.

group_name   <- 'age' #Name of column containing group labels.
date_name    <- 'date'      #Name of column containing dates.
outcome_name <- 'Pneum'    #Name of column containing outcome.
denom_name   <- 'denom'   #Name of column containing denominator to be used in offset.

#MOST DATES MUST BE IN FORMAT "YYYY-MM-01", exception is end of pre period, which is 1 day before end of post period
start_date        <- as.Date('1999-01-01') #Indicates the date of the first data point.
intervention_date <- as.Date('2009-04-01') #Indicates the date of intervention in the data.
end_date          <- as.Date('2016-12-01') #Indicates the date of the last data point.
pre_period        <- as.Date(c('1999-01-01', '2009-03-31')) #Range over which the data is trained for the CausalImpact model.
post_period       <- as.Date(c('2009-04-01', '2016-12-01')) #Range from the intervention date to the end date.
eval_period       <- as.Date(c('2012-01-01', '2016-12-01')) #Range over which rate ratio calculation will be performed.

#Run analysis, but don't generate HTML report
# source('synthetic_control_analysis.R', local = TRUE)
# source('synthetic_control_write_results.R', local = TRUE)
# source('synthetic_control_plot.R', local = TRUE)

#Run analysis and generate HTML report
source('synthetic_control_report.R', local = TRUE)
