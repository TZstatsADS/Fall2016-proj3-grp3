train<-function(dat_train,label_train,par=NULL) {
  library(gbm)
  
  if(is.null(par)){
    depth <- 3
  } else {
    depth <- par$depth
  }
  fit_gbm <- gbm.fit(x=dat_train, y=label_train,
                     n.trees=250,
                     distribution="bernoulli",
                     interaction.depth=depth,
                     bag.fraction = 0.5,
                     verbose=FALSE)
  best_iter <- gbm.perf(fit_gbm, method="OOB")
  
  return(list(fit=fit_gbm, iter=best_iter))
}
