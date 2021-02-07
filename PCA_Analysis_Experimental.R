########################################
## SCRIPT: PCA ANALYSIS
########################################
## License: Ugur Uresin
## Github: ugururesin
## Mail: uresin.ugur@gmail.com
########################################

### USER INPUTS
wdir = "C:/Users/uuresin/Desktop/MYGIT/R-codes"
setwd(wdir)
#

## PCA (LOAD A DATA CALLED "DATA")
data_pca <- princomp(data, scores=T, cor=T)
cum_facs <- cumsum(data_pca$sdev/sum(data_pca$sdev)) #cumulative sum of pca ratios
fac_cutoff = 0.5
as.numeric(which(cum_facs>=fac_cutoff)[1]) -> xfactors  
pca = preProcess(x=train_rca[-1], method='pca', pcaComp=xfactors)
#
train_rca_pca = predict(pca, train_rca)   #pca object is applied on train data
test_rca_pca = predict(pca, test_rca)     #pca object is applied on test data
new_measurement_pca= predict(pca, new_measurement)   #The object "pca" is applied on new_measurement
#
nb_model_rca_pca <- naive_bayes(Y~., data=train_rca_pca, usekernel=T)
pred_rca_pca <- predict(nb.model.rca3_pca, new_measurement_pca, type = 'prob')
pred_rca_pca[1,][1] -> new_mea_neg_prob_pca
pred_rca_pca[1,][2] -> new_mea_pos_prob_pca
#
#
#Sensivity Loss Calculation with PCA
length(new_measurement_pca) -> new_mea_length2
vector() -> sens.x2
for (zz in 1:new.mea.length2){
  new_measurement_pca -> nm2
  nm2[,zz] <- 0   
  p_sens2 <- predict(nb_model_rca_pca, nm2, type = 'prob')
  if(p_sens2[,2]<new_mea_pos_prob_pca){
    sens_x2[zz] <- new_mea_pos_prob_pca-p.sens2[,2]
  }else{
    sens_x2[zz] <- 0
  }
}
sens_x2
round(sens_x2,digits=2)
#
#PCA_reconstruction = PC scores*t(Eigenvectors)+Mean
t(t(data_pca$x %*% t(data_pca$rotation)) + data_pca$center)
###