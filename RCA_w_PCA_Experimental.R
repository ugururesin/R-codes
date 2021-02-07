###EXPERIMENTAL###
# ROOT CAUSE ANALYSIS w PCA
##PCA
data_rca3_pca <- princomp(data_rca3[-1], scores=T, cor=T)
cum_facs3 <- cumsum(data_rca3_pca$sdev/sum(data_rca3_pca$sdev)) #cumulative sum of pca ratios
fac_cutoff3 = 0.5
as.numeric(which(cum_facs3>=fac_cutoff3)[1]) -> xfactors3  
pca3 = preProcess(x=train.rca3[-1], method='pca', pcaComp=xfactors3)
#
train.rca3_pca = predict(pca3, train.rca3)   #pca object is applied on train data
test.rca3_pca = predict(pca3, test.rca3)     #pca object is applied on test data
new.measurement_pca= predict(pca3, new.measurement)   #The object "pca3" is applied on new.measurement
#
nb.model.rca3_pca <- naive_bayes(Y~., data=train.rca3_pca, usekernel=T)
p.rca3_pca <- predict(nb.model.rca3_pca, new.measurement_pca, type = 'prob')
p.rca3_pca[1,][1] -> new.mea.neg.prob_pca
p.rca3_pca[1,][2] -> new.mea.pos.prob_pca
#
#
#Sensivity Loss Calculation with PCA
length(new.measurement_pca) -> new.mea.length2
vector() -> sens.x2
for (zz in 1:new.mea.length2){
  new.measurement_pca -> nm2
  nm2[,zz] <- 0   
  p.sens2 <- predict(nb.model.rca3_pca, nm2, type = 'prob')
  if(p.sens2[,2]<new.mea.pos.prob_pca){
    sens.x2[zz] <- new.mea.pos.prob_pca-p.sens2[,2]
  }else{
    sens.x2[zz] <- 0
  }
}
sens.x2
round(sens.x2,digits=2)
#
#PCA_reconstruction = PC scores*t(Eigenvectors)+Mean
t(t(data_rca3_pca$x %*% t(data_rca3_pca$rotation)) + data_rca3_pca$center)
#