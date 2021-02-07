library(jsonlite)

##DATA IMPORTING
new_measurement <- read.csv(file=paste("./test/data/",dataname,"_MeasY3.csv",sep=""),sep=";",header=T)

##MODELS IMPORTING
if(T){org_model<-readRDS(file=paste("./test/models/", dataname, "_comp_model_nb1.Rds", sep=""))}

## MODEL TESTER
tester <- function(yourmodel, originalmodel, measurement){
  yourpred <- as.numeric(as.character(predict(yourmodel, newdata = measurement)))
  orgpred <- as.numeric(as.character(predict(originalmodel, newdata = measurement)))
  #cat(sprintf("\nTEST SONUCU (EGER MODEL YANLIS ISE FALSE CIKAR!):\n"))
  return(yourpred==orgpred)
}

## MODEL DIVIDER AND SAVER (IF JSON CONVERSION IS SUCCESFULL)
divideModel <- function(var){
  nameVar <- deparse(substitute(var))
  nameBody <- gsub("\\$","_",nameVar)
  nameJSON <- gsub("^","jsonDATA_",nameBody)
  name <- paste(nameJSON, ".JSON", sep="") 
  #
  varJSON <- toJSON(var)    #converting model part into JSON
  fromJSON(varJSON) -> var  #convert back & assign into model
  #
  if(tester(model_nb, org_model, new_measurement)==T){ write(varJSON,name)
  }
  else{ cat(sprintf("\nHATA BULUNDU!n"))
  }
}

## UZERINDE CALISMAK ICIN ORG_MODEL'IN BIR KOPYASINI OLUSTURALIM
org_model -> model_nb

## TEK SATIR KODLA IS TAMAMDIR (HATA VERMEDIGI SURECE DEVAM)
# HATA VERDIGI YERDE [1] son eki ekleyerek deneyin
# Ornek: jsonDATA_model_nb_finalModel_prior[1]
divideModel(model_nb$finalModel$data$x)