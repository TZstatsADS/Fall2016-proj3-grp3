test <- function(fit_train,dat_test) {
  library(randomForest)
  
  rf.preds <- predict(fit.rf, test, OOB=TRUE, type = "response")
  rf.preds[which(rf.pred > 0.5)] <- 1
  rf.preds[which(rf.pred <= 0.5)] <- 0
  
  return(rf.preds)
}
