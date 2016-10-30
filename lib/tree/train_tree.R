train <- function(dat_train,label_train){
  library(rpart)
  
  mycontrol = rpart.control(cp = 0, xval = 5)
  fittree = rpart(label_train~.,method = "class",data = dat_train,control = mycontrol)
  fittree$cptable
  cptarg = fittree$cptable[which(fittree$cptable[,4]==min(fittree$cptable[,4])),1]
  prunedtree = prune(fittree,cp=cptarg)
  
  return(prunedtree)
}
