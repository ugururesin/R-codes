###################################################
########### ERROR CONTRIBUTION ANALYSIS ###########
###################################################
# Package Install
#install.packages("mRMRe")
#library(mRMRe)

#Initial Data Check
str(training_data)

# Data Operations
ind <- sapply(training_data, is.integer)
training_data[ind] <- lapply(training_data[ind], as.numeric)
dd <- mRMR.data(data = training_data)

# Variable Poisitioning and Features
feats <- mRMR.classic(data = dd, target_indices = c(ncol(training_data)), feature_count = 10)
variableImportance <-data.frame('Importance'=feats@mi_matrix[nrow(feats@mi_matrix),])
variableImportance$feature <- rownames(variableImportance)
row.names(variableImportance) <- NULL

# Results
variableImportance <- na.omit(variableImportance)
variableImportance <- variableImportance[order(variableImportance$Importance, decreasing=TRUE),]
print(variableImportance)

ggplot(variableImportance, aes(x=reorder(feature,Importance), y=Importance,fill=Importance))+ 
  geom_bar(stat="identity", position="dodge")+ coord_flip()+
  ylab("Variable Importance")+
  xlab("")+
  ggtitle("Information Value Summary")+
  guides(fill=F)+
  scale_fill_gradient(low="red", high="green")