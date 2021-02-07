########################################
## SCRIPT: RANDOM DATA GENERATOR
########################################
## License: Ugur Uresin
## Github: ugururesin
## Mail: uresin.ugur@gmail.com
########################################

### USER INPUTS
wdir = "C:/Users/uuresin/Desktop/MYGIT/R-codes"
setwd(wdir)
#
tols_dir = "./data/random_data_generator/tolerances.csv";
data_dir = "./data/random_data_generator/sample_data.csv";
outd_dir = "./data/random_data_generator/output.csv";
#
colnum_labels = 12      #the column number of the labels in the data
colnum_features = 14    #the column number where features are start in the data
###


## DATA IMPORTING
data <- read.csv(data_dir, sep=";", header = T)[,-1]
tols <- read.csv(tols_dir, sep=";", header = T)

## FEATURE ANALYSIS
num_features = length(data) - colnum_features + 1


## FUNCTION
create_data <- function(neg_out, neg_in, pos_in, pos_out, num_features){
    round(sample(c(runif(num_features*2,neg_out,neg_in),
                   runif(num_features*2,pos_in,pos_out)),num_features),2)
}

## EXECUTION
data -> data1
for(i in 1:dim(tols)[1]){
    label <- tols[i,5]
    for(j in 1:tols[i,6]){
        vals <- create_data(tols[i,1], tols[i,2], tols[i,3], tols[i,4], num_features)
        data1 <- rbind(data1, c("SENTETIK_VERI", rep(NA,10), label, label, vals))
    }
}

## SAVING DATA
write.csv(data1, outd_dir, row.names = F)

## REMOVING VARIABLES
rm(list=ls())
