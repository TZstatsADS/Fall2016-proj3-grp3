test<-function(fit_train,dat_test) {
  library("gbm")
  pred<-predict(fit_train$fit,newdata=dat_test,n.trees=fit_train$iter,type="response")
  
  return(as.numeric(pred>0.5))
}



