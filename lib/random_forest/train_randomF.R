train <- function(dat_train,label_train){
  library(randomForest)
  library(MASS)
  
  cross_validation=function(features,labels,k,p){
    dat=cbind(features,labels)
    accuracy=vector()
    n=2000/k
    index=list()
    for (i in 1:k){
      index[[i]]=seq(i,2000,k)
    }
    for (i in 1:k){
      ind=index[[i]]
      train_dat=dat[-ind,]
      test_dat=dat[ind,]
      test_label=labels[ind]
      fit.rf=randomForest(labels ~ .,data = train_dat,mtry = 2,ntree = p,importance = TRUE,o.trace = 100)
      r <- predict(fit.rf, test_dat, OOB=TRUE, type = "response")
      r[which(r > 0.5)] <- 1
      r[which(r <= 0.5)] <- 0
    
      accuracy[i]=mean(r==test_label)
    }
    return(mean(accuracy))
  }
  gen_model=function(features,labels){
    k=5
    p=c(400,500,600)
    acc=vector()
    j=1
    for (i in p){
      acc[j]=cross_validation(features,labels,k,i)
      j=j+1
    }
    ind=which.min(acc)
    print(acc[ind])
    final.p=p[ind]
    dat=data.frame(x=features,y=as.factor(as.matrix(labels)))
    model=randomForest(y ~ .,data = dat,mtry = 2,ntree = final.p,importance = TRUE,o.trace = 100)
    return(model)
  }
  system.time(gen_model(data,labels))
  
  return(gen_model)
}
