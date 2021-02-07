### ACCURACY CALCULATOR
get_accuracy_nb <- function(model, train_data, test_data) {
  
  ### PREDICTION
  pred_tra <- predict(model, train_data[,-1], type = 'prob') #[,-1] to drop Y col
  head(cbind(pred_tra, train_data),n=5) #shows results for first 5 rows of training data 
  pred_tst <- predict(model, test_data[,-1], type = 'prob') #[,-1] to drop Y col
  head(cbind(pred_tst, test_data),n=5) #shows results for first 5 rows of training data 
  
  ### CONFUSION MATRIX: TRAINING
  res_tra <- predict(model, train_data[,-1]) #[,-1] to drop Y col
  cfm_tra <- table(res_tra, train_data$Y)
  
  ### CONFUSION MATRIX: TESTING
  res_tst <- predict(model, test_data[,-1]) #[,-1] to drop Y col
  cfm_tst <- table(res_tst, test_data$Y)
  
  ### ACCURACY
  acc_tra <- (sum(diag(cfm_tra)) / sum(cfm_tra))
  acc_tst <- (sum(diag(cfm_tst)) / sum(cfm_tst))
  
  return(c(acc_tra, acc_tst))
}