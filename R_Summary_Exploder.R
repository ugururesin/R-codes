### R SUMMARY FUNCTION EXPLODER
###############################
rawdata <- raw_data
total <- 6*(dim(rawdata)[2])
csum <- summary(rawdata)
varName <- colnames(raw_data)


## GETTING MIN VALUES
cmin <- c()
j <- 1
target <- total-5
for(i in seq(1,target,6)){
  temp1 <- gsub("Min.   :", "", csum[i])
  temp2 <- gsub("  ", "", temp1)
  cmin[j] <- as.numeric(temp2)
  j <- j + 1
}


## GETTING 1ST QUARTILE VALUES
c1q <- c()
j <- 1
for(i in seq(2,total-4,6)){
  temp1 <- gsub("1st Qu.:", "", csum[i])
  temp2 <- gsub("  ", "", temp1)
  c1q[j] <- as.numeric(temp2)
  j <- j + 1
}

## GETTING MEDIAN VALUES
cmed <- c()
j <- 1
for(i in seq(3,total-3,6)){
  temp1 <- gsub("Median :", "", csum[i])
  temp2 <- gsub("  ", "", temp1)
  cmed[j] <- as.numeric(temp2)
  j <- j + 1
}

## GETTING MEAN VALUES
cmea <- c()
j <- 1
for(i in seq(4,total-2,6)){
  temp1 <- gsub("Mean   :", "", csum[i])
  temp2 <- gsub("  ", "", temp1)
  cmea[j] <- as.numeric(temp2)
  j <- j + 1
}

## GETTING 3RD QUARTILE VALUES
c3q <- c()
j <- 1
for(i in seq(5,total-1,6)){
  temp1 <- gsub("3rd Qu.:", "", csum[i])
  temp2 <- gsub("  ", "", temp1)
  c3q[j] <- as.numeric(temp2)
  j <- j + 1
}

## GETTING MAX VALUES
cmax <- c()
j <- 1
for(i in seq(6,total,6)){
  temp1 <- gsub("Max.   :", "", csum[i])
  temp2 <- gsub("  ", "", temp1)
  cmax[j] <- as.numeric(temp2)
  j <- j + 1
}

## CREATING SUMMARY DATAFRAME
sum_df <- data.frame(varName, cmin, c1q, cmed, cmea, c3q, cmax)
write.csv(sum_df,"./data_summary.csv", row.names = FALSE)


### PLOTTING
for(r in 1:length(mylist)){
  err_med <- se_mat_med[r,]
  err_mean <- se_mat_mean[r,]
  err_cbi <- se_mat_cbi[r,]
  file_name = paste("./plots/avg_se_errors_", r, ".jpeg", sep="")
  jpeg(file=file_name, width = 900, height = 320)
  par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
  y_lim <- c(0, max(err_med, err_mean, err_cbi))
  plot(1:num_mis_points, err_med, type="l", col="red", lty=3,
       xlab=NA, #Change the x-axis label
       ylab=NA, #y-axis label
       main=NA,
       xlim = c(1, num_mis_points),
       ylim =  y_lim)
  lines(1:num_mis_points, err_mean, type="l", col="blue", lty=2)
  lines(1:num_mis_points, err_cbi, type="l", col="green", lty=1)
  title(xlab="Missing Value Index", col.lab="black")
  title(ylab="Average Standard Errors", col.lab="black")
  title_msg = paste("Average of Standard Errors of The Imputed Values (Iteration: ", r, ")", sep="")
  title(main=title_msg, col.main="black", font.main=1)
  axis(1, at=1:num_mis_points, las=1)
  legend("topright", inset=c(-0.13,0),
         legend=c("Median","Mean","CBI"),
         col=c("red","blue","green"),
         lty=c(3,2,1))
  dev.off()
}
#
### THE AVERAGE OF PERCENTAGE DIFFERENCES
if(TRUE){
    file_name = paste("./plots/data_summary", ".jpeg", sep="")
    jpeg(file=file_name, width = 900, height = 320)
    par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
    y_lim <- c(min(sum_df[,-1]), max(sum_df[,-1]))
    plot(1:dim(sum_df)[1], sum_df$cmin, type="l", col="red", lty=4, xaxt='n',
         xlab=NA, #Change the x-axis label
         ylab=NA, #y-axis label
         main=NA,
         xlim = c(1, dim(sum_df)[1]),
         ylim =  y_lim)
    lines(1:dim(sum_df)[1], sum_df$cmax, type="l", col="blue", lty=3)
    lines(1:dim(sum_df)[1], sum_df$cmea, type="l", col="black", lty=2)
    lines(1:dim(sum_df)[1], sum_df$cmed, type="l", col="green", lty=1)
    title(xlab="Variable Index", col.lab="black")
    title(ylab="Value", col.lab="black")
    title_msg = "Descriptive Statistics of the Data"
    title(main=title_msg, col.main="black", font.main=1)
    axis(1, at=1:dim(sum_df)[1], las=1)
    legend("topright", inset=c(-0.13,0),
           legend=c("Min", "Max", "Median","Mean"),
           col=c("red","blue","black","green"),
           lty=c(4,3,2,1))
    dev.off()
}