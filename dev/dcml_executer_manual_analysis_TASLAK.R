########################################################
############ DCML EXECUTER - MANUAL MODE ###############
########################################################
cat("\nSistem Modu: Manuel")
library(tcltk)

### ANALYSIS TYPE SELECTION
anys_list <- c("Olcum Noktasi Azaltma", "Olcum Noktasi Tahminleme", "Hata Tahminleme")
anys_win_title <- "   Lütfen Analiz Tipini Seciniz!   "
anys_selected <- tk_select.list(anys_list, preselect=NULL, multiple=FALSE, title=st_title)
cat(sprintf("\nSecilen Analiz Tipi: %s\n",anys_selected))


### DATA SOURCE SELECTION
data_source_selected <- tk_select.list(c("Lokal Veri (.csv)", "Veritabani (Webservice)"),
                                       preselect = NULL,
                                       multiple = FALSE,
                                       title =st_title)

### SETTING DATALISTS
if(data_source_selected=="Lokal Veri (.csv)"){datalist <-  datalocal_list[,1]}
if(data_source_selected=="Veritabani (Webservice)"){datalist <- database_list[,1]}

### DATA SELECTION
data_selected <- tk_select.list(datalist, preselect=NULL, multiple=FALSE, title=win_title)

### DATA DATE SELECTION



###




### ANALYSIS 1- MEASUREMENT POINT REDUCTION
########################################################
if(anys_selected=="Olcum Noktasi Azaltma"){
  
  ## DATA IMPORTING
  if(data_source=="database"){
    ######### BURAYA SON OLCUMU CEKMEK ICIN ILGILI KOD GIRILMELI
    data_headname <- database_list[i,1]
    data_begindate <- database_list[i,2]
    data_lastdate <- database_list[i,3]
    dataname = gsub(" ","_",data_headname)
    source("./scripts/dcml_database_script.R")
    raw_data <- raw_tables$list ###--DAHA SONRA MODIFIYE EDILECEK
    ### new_measurement ????
  }
  if(data_source=="local"){
    data_headname <- datalocal_list[i,2]
    data_dir <- paste("data/_datalocal/data_training/", data_headname, ".csv",sep="")
    raw_data <- read.csv(data_dir, sep=";", header = T)
    dataname = gsub(" ","_",data_headname)
  }
  
  ## DATA RELATED MEASSAGE
  cat(sprintf("\n%s VERISI ANALIZ EDILECEK...\n",data_headname))
  
  ## RUNNING MPR MODEL
  if(T){
    source("./scripts/dcml_module_dataprocessing.R")
    source("./scripts/dcml_module_modeling_stat.R")
  }
}
###

### MISSING MEASUREMENT ESTIMATION
########################################################
if(anys_selected=="Olcum Noktasi Tahminleme"){
  
  ## DATA IMPORTING
  if(data_source=="database"){
    ######### BURAYA SON OLCUMU CEKMEK ICIN ILGILI KOD GIRILMELI
    data_headname <- database_list[i,1]
    data_begindate <- database_list[i,2]
    data_lastdate <- database_list[i,3]
    dataname = gsub(" ","_",data_headname)
    source("./scripts/dcml_database_script.R")
    raw_data <- raw_tables$list ###--DAHA SONRA MODIFIYE EDILECEK
    ### new_measurement ????
  }
  if(data_source=="local"){
    data_headname <- datalocal_list[i,2]
    data_dir <- paste("data/_datalocal/data_measurement/", data_headname, ".csv",sep="")
    new_measurement <- read.csv(data_dir, sep=";", header = T)
    dataname = gsub(" ","_",data_headname)
  }

  ## RUN MISSING POINT ESTIMATOR
  if(!(!is.na(new_measurement))){
    cat("Olcum setinde eksik veri bulunamadi! ")
  }else{
    missing_measurement <- new_measurement
    source("./scripts/dcml_module_prediction_stat.R") 
  }
    
}
###

### FAILURE PREDICTION
########################################################
if(anys_selected=="Hata Tahminleme"){
  
  ### --ADD DATA
  ### -- ADD DATA PROCESSING
  
  ## RUN FAILURE PREDICTION
  source("./scripts/dcml_module_prediction_ml.R")
}
###