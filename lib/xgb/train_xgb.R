train<-function(dat_train,label_train){
  library(xgboost)
  depth<-5
  err.cv<-c()
  for(i in 1:depth){
    fit.cv<-xgb.cv(data=train_data,label=train_label,max.depth=i,eta=1,nround=50,objective="binary:logistic",nfold=5)
    err.cv<-c(err.cv,fit.cv$test.error.mean)
  }
  depth.best<-which.min(err.cv)
  fit<-xgboost(train_data,train_label,max.depth=3,eta=1,nround=50,objective="binary:logistic")
  return(fit=fit)
}