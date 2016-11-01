train <- function(dat_train,label_train){
  library(randomForest)
  library(MASS)
  
  bestmtry <- tuneRF(dat_train, label_train, ntreeTry=100, stepFactor=1.5,improve=0.01, trace=TRUE, plot=TRUE, dobest=FALSE)
  mtry = bestmtry[which(bestmtry[,2]==min(bestmtry[,2])),1]
  fit.rf <- randomForest(label_train ~ dat_train, mtry = mtry, importance = TRUE, o.trace = 100)
  
  return(fit.rf)
}