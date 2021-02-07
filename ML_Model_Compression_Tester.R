compress_model <- function(model){
  
  #MUST BE KEPT
  #c() -> model$modelInfo
  #c() -> model$modelType
  #c() -> model$terms
  #c() -> model$coefnames
  #c() -> xlevels
  
  #c() -> model$levels
  #c() -> model$finalModel
  #c() -> model$preProcess
  
  #MAY NOT BE STORED
  c() -> model$method
  c() -> model$results
  c() -> model$pred
  c() -> model$bestTune
  c() -> model$call
  c() -> model$dots
  c() -> model$control
  c() -> model$trainingData
  c() -> model$resample
  c() -> model$resampledCM
  c() -> model$perfNames
  c() -> model$maximize
  c() -> model$ylimits
  c() -> model$times
 
  return(model)  
}


tester <- function(model, new_measurement){
  model -> modelS
  compress_model(modelS) -> modelS
  original <- as.numeric(as.character(predict(model, newdata = new_measurement)))
  compresd <- as.numeric(as.character(predict(modelS, newdata = new_measurement)))
  return(original==compresd)
}


tester(model_nb1,new_measurement)
tester(model_nb2,new_measurement)
tester(model_nb3,new_measurement)

tester(model_nn1,new_measurement)
tester(model_nn2,new_measurement)
tester(model_nn3,new_measurement)

tester(model_rf1,new_measurement)
tester(model_rf2,new_measurement)
tester(model_rf3,new_measurement)