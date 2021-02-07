########################################
## SCRIPT: LABEL CREATOR FOR COR-MAT
########################################
## License: Ugur Uresin
## Github: ugururesin
## Mail: uresin.ugur@gmail.com
########################################

### USER INPUTS
wdir = "C:/Users/uuresin/Desktop/MYGIT/R-codes"
setwd(wdir)
#

##NOTES: There should be correlation matrix called cormat!
labelpairs <- function(cormat){
  dim(cormat)[1] -> cm_rows
  pair_labels <- data.frame(matrix(NA, nrow=cm_rows, ncol=cm_rows)) #Define an empty df for labels
  for (i in 1:cm_rows){
    for (k in 1:cm_rows){
      sprintf("X%i - X%i",i,k) -> pair_labels[i,k]   
      k=k+1
      }
    i=i+1
    }
  return(pair_labels)
}
###