cv.function <- function(X.train, y.train, d, K){
  
  n <- length(y.train)
  n.fold <- floor(n/K)
  s <- sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))  
  cv.error <- rep(NA, K)
  
  for (i in 1:K){
    train.data <- X.train[s != i,]
    train.label <- y.train[s != i]
    test.data <- X.train[s == i,]
    test.label <- y.train[s == i]
    
    par <- list(depth=d)
    fit <- gbm.fit(x=train.data, y=train.label,
                   n.trees=250,
                   distribution="bernoulli",
                   interaction.depth=par$depth,
                   bag.fraction = 0.5,
                   verbose=FALSE)
    best_iter <- gbm.perf(fit, method="OOB")
    fit.gbm<-list(fit=fit,iter=best_iter)
    pred <- predict(fit.gbm$fit, newdata=test.data,n.trees=fit.gbm$iter,type="response")  
    pred<-as.numeric(pred>0.5)
    
    cv.error[i] <- mean(pred != test.label)  
    
  }			
  return(c(mean(cv.error),sd(cv.error)))
  
}


train<-function(dat_train,label_train) {
  library(gbm)
  
  depth_values <- c(seq(3,15,3))
  err_cv <- array(dim=c(length(depth_values), 2))
  K <- 5  
  for(k in 1:length(depth_values)){
    cat("k=", k, "\n")
    err_cv[k,] <- cv.function(dat_train, label_train, depth_values[k], K)
  }
  #save(err_cv, file="C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/output/err_train_baseline1.RData")
  depth_best <- depth_values[which.min(err_cv[,1])]
  par_best <- list(depth=depth_best)
  
  print(err_cv)
  print(depth_best)
  fit_gbm <- gbm.fit(x=dat_train, y=label_train,
                     n.trees=250,
                     distribution="bernoulli",
                     interaction.depth=par_best$depth,
                     bag.fraction = 0.5,
                     verbose=FALSE)
  best_iter <- gbm.perf(fit_gbm, method="OOB")
  fit_train<-list(fit=fit_gbm, iter=best_iter)
  #save(fit_train, file="./output/fit_train_baseline.RData")
  return(fit_train)

}

system.time(result<-train(color_data,label_train))
