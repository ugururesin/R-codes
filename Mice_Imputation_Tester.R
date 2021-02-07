##IMPUTATION TESTER

#load a missing_data
missing_data <- raw_data1

if(T){
  idr <- as.integer(runif(1,1,dim(missing_data)[1]))
  idc <- as.integer(runif(1,1,dim(missing_data)[2]))
  
  missing_data -> new_data
  new_data[idr,idc] <- NA
  new_data[idr+1,idc] <- NA
  new_data[idr+2,idc] <- NA
  new_data[idr+3,idc] <- NA
  
  imputation <- mice(new_data, m=1, method="pmm", maxit=imputation_iterations, seed=500)
  new_data <- complete(imputation,1)
  
  cat("Original value:\n")
  print(missing_data[idr,idc])
  cat("Imputated value:\n")
  print(new_data[idr,idc])
}