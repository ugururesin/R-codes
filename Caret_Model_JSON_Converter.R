########################################
## SCRIPT: CARET TO JSON CONVERTER
########################################
## License: Ugur Uresin
## Github: ugururesin
## Mail: uresin.ugur@gmail.com
########################################

### USER INPUTS
wdir = "C:/Users/uuresin/Desktop/MYGIT/R-codes"
setwd(wdir)
#

## LIBRARY IMPORT
library(jsonlite)

## DATA IMPORTING
new_measurement <- read.csv(file=paste("./data/caret2json/example_data.csv", ,sep=";",header=T)

## MODELS IMPORTING
if(T){org_model<-readRDS(file="./data/caret2json/example_caret_model.Rds")}

## MODEL TESTER
tester <- function(yourmodel, originalmodel, measurement){
  yourpred <- as.numeric(as.character(predict(yourmodel, newdata = measurement)))
  orgpred <- as.numeric(as.character(predict(originalmodel, newdata = measurement)))
  #cat(sprintf("\nTEST RESULTS (EGER MODEL YANLIS ISE FALSE CIKAR!):\n"))
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
  if(tester(test_model, org_model, new_measurement)==T){ write(varJSON,name)
  }
  else{ cat(sprintf("\nPREDICTION ERROR!n"))
  }
}

## CREATE A COPY OF THE MODEL
org_model -> test_model

# IF YOU GET "PREDICTION ERROR" --> TRY TO ADD [1] to the class!
# Example: jsonDATA_test_model_finalModel_prior[1]
divideModel(test_model$finalModel$data$x)