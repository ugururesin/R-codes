########################################
## SCRIPT: MULTIPLE REGRESSION
########################################
## License: Ugur Uresin
## Github: ugururesin
## Mail: uresin.ugur@gmail.com
########################################

### USER INPUTS
wdir = "C:/Users/uuresin/Desktop/MYGIT/R-codes"
setwd(wdir)
#

# FACTORS ARE CONVERTED INTO NUMERIC
trial_data$Y <- as.numeric(trial_data$Y)
trial_data$Y -1 -> trial_data$Y

# TRAIN/TEST SET PARTITION
set.seed(125)
as.integer(runif(30,10,360)) -> test_idx
trial_data[-test_idx,] -> train_data
trial_data[test_idx,] -> test_data

# MODEL FIT
lm(formula="Y~.", data=train_data) -> test_model

# DIFFERENCES
as.integer(predict(test_model, test_data, se.fit = T)$fit) - test_data$Y -> test_diff
mean(abs(test_diff))