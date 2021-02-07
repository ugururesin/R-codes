## IMPORTING DATABASE LIST
dblist_dir <- "C:/Users/uuresin/Desktop/MyGIT/DCML/main/data/database_list.csv" 
dblist <- read.csv(dblist_dir, sep=";", header=T)

## SOURCING WEBSERVICE CODE
source("C:/Users/uuresin/Desktop/MyGIT/DCML/main/scripts/dcml_system_functions.R")

for (i in 1:length(dblist[,1])){
  
  #GETTING DATA VIA WEBSERVICE
  data_headname = dblist[i,1]
  data_begindate = gsub("_", "-", dblist[i,2])
  data_lastdate = gsub("_", "-", dblist[i,3])
  source("C:/Users/uuresin/Desktop/MyGIT/DCML/main/scripts/dcml_database_script.R")
  
  ##CREATING A PROPER VARIABLE NAME FOR THE DATA
  var_name <- paste(c("data_", i), collapse = "")
  
  ##ASSINING THE DATA TO THE VARIABLE NAME  
  do.call("<-",list(var_name, raw_tables$list))
}