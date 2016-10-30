test <- function(fit_train,dat_test) {
  library(rpart)
  
  fit.preds = predict(fit_train,newdata=dat_test,type="class")
  
  return(fit.preds)
}
