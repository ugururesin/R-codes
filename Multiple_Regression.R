# RAW DATA
dataset_sce1[,-1] -> denedata

# FACTORS ARE CONVERTED INTO NUMERIC
denedata$Y <- as.numeric(denedata$Y)
denedata$Y -1 -> denedata$Y

# TRAIN/TEST SET PARTITION
set.seed(125)
as.integer(runif(30,10,360)) -> denetestidx
denedata[-denetestidx,] -> denetrain
denedata[denetestidx,] -> denetest

# MODEL FIT
lm(formula="Y~.", data=denetrain) ->denemodel

# DIFFERENCES
as.integer(predict(denemodel, denetest, se.fit = T)$fit) - denetest$Y -> denediff
mean(abs(denediff))